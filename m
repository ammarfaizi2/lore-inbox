Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbREOJgm>; Tue, 15 May 2001 05:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbREOJgc>; Tue, 15 May 2001 05:36:32 -0400
Received: from thimm.dialup.fu-berlin.de ([160.45.217.207]:39429 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S262707AbREOJgZ>; Tue, 15 May 2001 05:36:25 -0400
Date: Tue, 15 May 2001 11:34:53 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: John R Lenton <john@grulic.org.ar>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de
Subject: VIA's Southbridge bug (was: PATCH 2.4.5.1: Fix Via interrupt routing issues)
Message-ID: <20010515113453.A3539@pua.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 02:07:53PM -0300, John R Lenton wrote:
> On Sun, May 13, 2001 at 01:28:06PM -0400, Jeff Garzik wrote:
> > For those of you with Via interrupting routing issues (or
> > interrupt-not-being-delivered issues, etc), please try out this patch
> > [...]
> Just to add a little noise: My box (msi 694d pro AI motherboard,
> revI, i.e. vt82c686a) been a *lot* stabler since I removed the
> Live! and dropped back to the onboard soundcard.
> [...]
> If I could put in words the difference between the Live! and the
> via, I would. Alas, I can't, so you're stuck with this inane
> rant:
> 
>     please please please fix it.

This has nothing to do with the routing issue, but is a bigger problem by
itself :(

The VIA chipset is buggy, and your Soundblaster Live! increases the likelyhood
of triggering that bug. This is a rather well documented problem, read an
english article about it on http://www.au-ja.de/review-kt133a-1-en.html and a
german article on the discussion of this on the lkml on
http://www.au-ja.de/review-kt133a-linux.html (if you don't read German this is
not a problem, as all links found there refer to english pages).

You seem to have bad luck, as the 686a should not be a buggy as the 686b.

Bottom line: Try to get a BIOS upgrade and hope that VIA will opensource and
contribute their Windows patch to linux...

Regards, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de
