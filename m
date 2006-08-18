Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWHRXez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWHRXez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWHRXez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:34:55 -0400
Received: from xenotime.net ([66.160.160.81]:54197 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964940AbWHRXey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:34:54 -0400
Date: Fri, 18 Aug 2006 16:37:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH][CHAR] Return better error codes if drivers/char/raw.c
 module init fails
Message-Id: <20060818163753.8f25d58d.rdunlap@xenotime.net>
In-Reply-To: <20060818162743.f97ff431.akpm@osdl.org>
References: <200608180918.30483.eike-kernel@sf-tec.de>
	<20060818162743.f97ff431.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 16:27:43 -0700 Andrew Morton wrote:

> On Fri, 18 Aug 2006 09:18:30 +0200
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> 
> > Currently this module just returns 1 if anything on module init
> > fails. Store the error code of the different function calls and
> > return their error on problems.
> > 
> > I'm not sure if this doesn't need even more cleanup, for example
> > kobj_put() is called only in one error case.
> > 
> 
> You seem to be using kmail in funky-confuse-sylpheed mode.  Inlined
> patches in plain-text emails are preferred, please.  

Something about the SLIM docum. patch did that too, although
it was not an attachment.
Sylpheed had trouble with the line endings....
Saving the patch to a file works well, but replying to it looks
like garbage.

---
~Randy
