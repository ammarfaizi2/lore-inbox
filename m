Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280757AbRKJXWx>; Sat, 10 Nov 2001 18:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKJXWo>; Sat, 10 Nov 2001 18:22:44 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1781
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280757AbRKJXW1>; Sat, 10 Nov 2001 18:22:27 -0500
Date: Sat, 10 Nov 2001 15:22:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ivanovich <ivanovich@menta.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile problem 2.4.14
Message-ID: <20011110152214.E446@mikef-linux.matchmail.com>
Mail-Followup-To: Ivanovich <ivanovich@menta.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01111022150000.00265@gryppas> <01111023170400.01130@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01111023170400.01130@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 11:17:04PM +0100, Ivanovich wrote:
> On Saturday 10 November 2001 21:15, Panagiotis Moustafellos wrote:
> 
> > I am really getting a hard time compiling the 2.4.14..
> > My current system has a 2.4.13 (by patching all the way
> > from 2.4.9), so I patched the sources, yes after make clean,
> > make menuconfig, and make dep ; make bzImage, I get this
> > message (during the compilation of vmlinux )
> 
> > Could someone give me some instruction on what could be
> > the problem, and hopefully, how to fix it?
> > Thanks in advance
> 
> too much patching can't be good... 
> you should get the sources of the 2.4.14 and you'll have less headaches

If the patches are applied properly, and no rejects are noticed, then you
should be able to patch as much as you want, and it will be the same as af
downloading directly from kernel.org.

Now, if there was a previous kernel compile, and then several patches
applied, (say from 2.4.0 all the way up to 2.4.14...) then you'll probably
have to run "make mrproper" as mentioned by Keith...

If I've left anything out, please let me knwo...

Mike
