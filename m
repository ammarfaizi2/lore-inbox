Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWGCSq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWGCSq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWGCSq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:46:58 -0400
Received: from baikonur.stro.at ([213.239.196.228]:45981 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1750783AbWGCSq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:46:57 -0400
Date: Mon, 3 Jul 2006 20:46:47 +0200
From: maximilian attems <maks@sternwelten.at>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, klibc@zytor.com,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, torvalds@osdl.org,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060703184647.GA14100@baikonur.stro.at>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <44A16E9C.70000@zytor.com> <Pine.LNX.4.64.0606290156590.17704@scrub.home> <200607031430.47296.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607031430.47296.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 02:30:45PM -0400, Rob Landley wrote:
> On Wednesday 28 June 2006 8:04 pm, Roman Zippel wrote:
> > If you are concerned about this simply keep the whole thing optional.
> > Embedded application usually know their boot device and they don't need no
> > fancy initramfs.
> 
> Actually, a lot of embedded applications like initramfs because it saves 
> memory (a ram block device, a filesystem driver, and filesystem overhead.)  
> Don't use embedded applications as a reason _not_ to do this!
> 
> BusyBox has had explicit support for initramfs (switch_root) for several 
> versions now.  I pestered HPA about building a subset of BusyBox against 
> klibc (and cross-compiling klibc for non-x86 platforms) at the Consumer 
> Electronics Linux Forum, but haven't had time to follow up yet.
> 
> Rob

well but busybox is big nowadays and generally compiled against glibc.
i'm quite eager to kick busybox out of default Debian initramfs-tools
to have an klibc only default initramfs. those tools are needed atm,
and there is not enough yet. afaik suse adds sed on klibc with a minimal
patch and we'd liked to have stat, kill and readlink on klibc-utils.

how about busybox on klibc?

--
maks
