Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVAXX2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVAXX2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVAXXZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:25:09 -0500
Received: from mta03.pge.com ([131.89.129.73]:33730 "EHLO mta03.pge.com")
	by vger.kernel.org with ESMTP id S261670AbVAXXYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:24:35 -0500
Date: Mon, 24 Jan 2005 15:16:36 -0800
From: Edward Peschko <esp5@pge.com>
To: Richard Henderson <rth@redhat.com>
Cc: gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       binutils@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Message-ID: <20050124231636.GC19422@venus>
References: <20050124222449.GB16078@venus> <20050124231047.GC29545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124231047.GC29545@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 03:10:47PM -0800, Richard Henderson wrote:
> On Mon, Jan 24, 2005 at 02:24:49PM -0800, Edward Peschko wrote:
> > What I'd like to do is be able to set up my LD_LIBRARY_PATH 
> > so that I can reference it from the point of view of the 
> > *executable*:
> > 
> > 	setenv LD_LIBRARY_PATH   "*/../lib:....."
> > 
> > Here, read "* == full path of dirname of executable".
> 
> See -Wl,-rpath,'$ORIGIN/../lib/'
> 
> 
> r~

cool.. any chance for some syntactic sugar so me (and other 
users/vendors) wouldn't need to change any of their build scripts 
and compilation processes?

The only thing I would see as a drawback would be backwards compatibility,
but how often do people have directories named '*'?

Ed
