Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293425AbSB1VxP>; Thu, 28 Feb 2002 16:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310143AbSB1Vvl>; Thu, 28 Feb 2002 16:51:41 -0500
Received: from linux.kappa.ro ([194.102.255.131]:23433 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S310127AbSB1Vt1>;
	Thu, 28 Feb 2002 16:49:27 -0500
Date: Thu, 28 Feb 2002 23:50:59 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Rankin <cj.rankin@ntlworld.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.18 : lots of "state D" processes (more)
In-Reply-To: <20020228183120.C1705@inspiron.school.suse.de>
Message-ID: <Pine.LNX.4.31.0202282350070.5438-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The process who gets "hunged" is:
  889 ?        D      0:00 /usr/bin/perl
/usr/share/printconf/util/printconf_mfomatic.pl -d epl5800-633554.foo

And this doesn't happen with your patch, it does happen with rmap12g,
hadn't test simple 2.4.19-pre1

..


On Thu, 28 Feb 2002, Andrea Arcangeli wrote:

> On Thu, Feb 28, 2002 at 12:38:13PM +0200, Teodor Iacob wrote:
> > Hello,
> >
> > I got a few stats "D" process also with 2.4.19-pre1-rmap12g, the processes
> > were using my usb printer, which actually I never got it to work anyway
> > because this was the first kernel to try to make it work, and ofc I
> > couldn't kill the processes, but the reboot went cleanly.
>
> Can you reproduce on 2.4.19pre1aa1?
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1.bz2
>
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

