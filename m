Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWARDJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWARDJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWARDJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:09:17 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:22733 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964866AbWARDJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:09:17 -0500
Date: Tue, 17 Jan 2006 22:05:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack
  backtraces
To: Sam Ravnborg <sam@ravnborg.org>
Cc: mita@miraclelinux.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200601172208_MC3-1-B612-EE85@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060117181416.GB8047@mars.ravnborg.org>

On Tue, 17 Jan 2006 19:14:16 +0100, Sam Ravnborg wrote:

> On Tue, Jan 17, 2006 at 09:22:09PM +1100, Keith Owens wrote:
> > Should not be a problem for ksymoops.  Most entries use this regex,
> > where [ ] is optional.
> 
> In that case can we then remove the CONFIG option?
> If needed to be configurable a commandline option could do it,
> so one does not have to rebuild the kernel.

I guess it could be a command-line option, but how many times would
you change it?  Only traps.o get rebuilt when you change the config,
and that plus the kernel relink is pretty fast anyway.

-- 
Chuck
