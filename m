Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270953AbRHOAHo>; Tue, 14 Aug 2001 20:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270954AbRHOAHf>; Tue, 14 Aug 2001 20:07:35 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:1266 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S270953AbRHOAHQ>; Tue, 14 Aug 2001 20:07:16 -0400
Date: Tue, 14 Aug 2001 20:07:25 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Anders Larsen <anders@alarsen.net>, linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
In-Reply-To: <E15Wl5b-0001vV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0108141951430.769-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Alan Cox wrote:

> Date: Tue, 14 Aug 2001 21:47:03 +0100 (BST)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Anders Larsen <anders@alarsen.net>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, PinkFreud <pf-kernel1@mirkwood.net>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Are we going too fast?
> 
> > Mike didn't mention any details of the hardware where he's experiencing this
> > bug, but is it possibly a multiprocessor machine?
> > Since I only have UP's to test on, the qnxfs might have SMP issues.
> > 
> > Could someone please glance through the code in fs/qnx4 to check if there
> > are any obvious problems?
> 
> If I get time tomorrow I'll test the qnxfs code on a dual PPro


Woah, good point.  While the system I'm trying this on is only a single
cpu machine (AMD K6), I noticed (after I compiled, alas) that the kernel
was compiled with the SMP option enabled - whoops.  I meant to change that
back to UP, but haven't done so as of yet.


Linux boromir 2.4.8 #1 SMP Sun Aug 12 14:08:25 EDT 2001 i586 unknown

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 6
model name	: AMD-K6tm w/ multimedia extensions
stepping	: 1
cpu MHz		: 199.684
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 398.13


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.


