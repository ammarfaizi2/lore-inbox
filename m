Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSKYRce>; Mon, 25 Nov 2002 12:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSKYRce>; Mon, 25 Nov 2002 12:32:34 -0500
Received: from molly.vabo.cz ([160.216.153.99]:39946 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id <S261829AbSKYRcd>;
	Mon, 25 Nov 2002 12:32:33 -0500
Date: Mon, 25 Nov 2002 18:39:42 +0100 (CET)
From: Tomas Konir <moje@molly.vabo.cz>
X-X-Sender: moje@moje.vabo.cz
To: Matthias Andree <matthias.andree@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
In-Reply-To: <20021125171543.GD9564@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44L0.0211251837200.4059-100000@moje.vabo.cz>
References: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
 <20021125171543.GD9564@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Matthias Andree wrote:

> On Mon, 25 Nov 2002, Clemmitt Sigler wrote:
> 
> > I'd been running 2.4.20-rc3 for two days.  While rebooting it tonight
> > fsck.ext3 corrupted my / partition during an automatic fsck of the
> > partition (caused by the maximal mount count being reached).  (I had
> > backups so I was able to recover :^)  The symptoms were that some files
> > like /etc/fstab and dirs like /etc/rc2.d disappeared -- not good.
> > 
> > My system is Debian Testing, with Debian e2fsprogs version
> > 1.29+1.30-WIP-0930-1.  I use ext3 partitions with all options set to
> > the defaults (ordered data mode).  This is an SMP system, in case
> > that matters.  Please e-mail me for any other details that might help.
> 
> Retry with 1.32. I don't think the corruption is kernel-related, but I
> may be wrong.
> 
hm
My / XFS partition was corrupted after reboot the 2.4.20-rc3-xfs.
I rebooted twice and same thing done after each reboot.
My opinion is that this is kernel-related.

	MOJE

-- 
Tomas Konir
Brno
ICQ 25849167


