Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSKYRIb>; Mon, 25 Nov 2002 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSKYRIb>; Mon, 25 Nov 2002 12:08:31 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1029 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261663AbSKYRIa>; Mon, 25 Nov 2002 12:08:30 -0500
Date: Mon, 25 Nov 2002 18:15:43 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021125171543.GD9564@merlin.emma.line.org>
Mail-Followup-To: Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Clemmitt Sigler wrote:

> I'd been running 2.4.20-rc3 for two days.  While rebooting it tonight
> fsck.ext3 corrupted my / partition during an automatic fsck of the
> partition (caused by the maximal mount count being reached).  (I had
> backups so I was able to recover :^)  The symptoms were that some files
> like /etc/fstab and dirs like /etc/rc2.d disappeared -- not good.
> 
> My system is Debian Testing, with Debian e2fsprogs version
> 1.29+1.30-WIP-0930-1.  I use ext3 partitions with all options set to
> the defaults (ordered data mode).  This is an SMP system, in case
> that matters.  Please e-mail me for any other details that might help.

Retry with 1.32. I don't think the corruption is kernel-related, but I
may be wrong.

-- 
Matthias Andree
