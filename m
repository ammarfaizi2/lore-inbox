Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267801AbUHEREk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267801AbUHEREk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUHERDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:03:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:35495 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267811AbUHERBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:01:51 -0400
Date: Thu, 5 Aug 2004 19:00:44 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040805170044.GA5388@suse.de>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040805165410.GA555@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Aug 05, Tom Rini wrote:

> On Thu, Aug 05, 2004 at 04:12:57PM +0200, Olaf Hering wrote:
> >  On Fri, Jul 30, Tom Rini wrote:
> > 
> > > 
> > > +aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
> > 
> > this should be -Wa,-mppc64bridge for some reasons.
> 
> That, er, doesn't make sense.  The assembler needs -Wa,?

The cmdline was 'gcc .. -mppc64bridge ..'
But there is more breakage with g5 32bit, I'm looking at it right now.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
