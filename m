Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbRLTTdn>; Thu, 20 Dec 2001 14:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286337AbRLTTd3>; Thu, 20 Dec 2001 14:33:29 -0500
Received: from ntmail.avint.net ([198.165.75.239]:19207 "EHLO NTMAIL.avint.net")
	by vger.kernel.org with ESMTP id <S286336AbRLTTdR>;
	Thu, 20 Dec 2001 14:33:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Brendan Pike <spike@superweb.ca>
Reply-To: spike@superweb.ca
Organization: Linux User
To: hahn@physics.mcmaster.ca
Subject: Re: IDE Harddrive Performance
Date: Thu, 20 Dec 2001 15:33:07 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0112201307120.9437-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0112201307120.9437-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01122015330703.27161@spikes>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 02:08 pm, you wrote:
> > here is -T
> >
> > [root@spikes spike]# /sbin/hdparm -T /dev/hda
> > /dev/hda:
> > Timing buffer-cache reads:   128 MB in  3.89 seconds = 32.90 MB/sec
>
> well, no wonder.  on a modern machine, -T shows 200 MB/s.
> what kind of CPU/motherboard is this?  I'm guessing it's
> a socket7 system with PC66 dram, perhaps just edo.  the problem
> is that it's dram and probably PCI infrastructure can't
> really handle much bandwidth, so doesn't keep the disk "streaming".

Actually it is a Socket 7 AMD 300 with 384MB SDRAM PC-133 running at 100Mhz 
Bus clock.
