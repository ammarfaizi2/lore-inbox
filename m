Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSKYRbJ>; Mon, 25 Nov 2002 12:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSKYRbI>; Mon, 25 Nov 2002 12:31:08 -0500
Received: from jrt.me.vt.edu ([128.173.188.212]:12164 "HELO jrt.me.vt.edu")
	by vger.kernel.org with SMTP id <S262322AbSKYRbH>;
	Mon, 25 Nov 2002 12:31:07 -0500
Date: Mon, 25 Nov 2002 13:37:46 -0500 (EST)
From: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
In-Reply-To: <20021125171543.GD9564@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.33L2.0211251333120.2368-100000@jrt.me.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Mon, 25 Nov 2002, Matthias Andree wrote:
> > I'd been running 2.4.20-rc3 for two days.  While rebooting it tonight
> > fsck.ext3 corrupted my / partition during an automatic fsck of the
> > partition (caused by the maximal mount count being reached).
> > My system is Debian Testing, with Debian e2fsprogs version
> > 1.29+1.30-WIP-0930-1.  I use ext3 partitions with all options set to
> > the defaults (ordered data mode).
>
> Retry with 1.32. I don't think the corruption is kernel-related, but I
> may be wrong.

I just checked the Debian packages, and e2fsprogs 1.32 is available
on Debian Unstable.  If it is indeed a mismatch between Debian Testing's
e2fsprogs version and 2.4.20-rc3, Debian users should upgrade e2fsprogs
before upgrading their kernel.  Forewarned is forearmed :^)  Thanks.

					Clemmitt Sigler

