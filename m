Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUHBHqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUHBHqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHBHqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 03:46:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:8110 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266339AbUHBHqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 03:46:01 -0400
Date: Mon, 2 Aug 2004 09:45:53 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040802074553.GA4998@suse.de>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040730190731.GQ16468@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jul 30, Tom Rini wrote:

> On Fri, Jul 30, 2004 at 08:59:01PM +0200, Giuliano Pochini wrote:
> 
> > On Thu, 29 Jul 2004 07:43:47 -0700
> > Tom Rini <trini@kernel.crashing.org> wrote:
> > > > I had no time to do a lot of testing, but it seems that binutils 2.15 +
> > > > gcc 3.3.3 is a bad one too. I didn't try to compile the kernel (which
> > > > may also break), but at least I couldn't compile gcc 3.4.1 with the
> > > > above combination. It seems that as doesn't get the -mxxx parameter
> > > > required to compile altivec stuff. Hacking the Makefile to make it
> > > > pass -Wa,-m7455 helped a little, but it eventually failed in another
> > > > weird way. I hadn't time to investigate further, sorry.
> > >
> > > Stock gcc-3.3.3 or from the hammer branch ?
> > 
> > Stock.
> 
> That is interesting.  Olaf, is gcc-3.3.x + binutils-2.15 one of the
> combinations you've got in your matrix of toolchains?

yes, it worked ok for kernel builds. gcc-3_3-branch + binutils 2.15

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
