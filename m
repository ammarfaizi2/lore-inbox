Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132776AbRDDKUd>; Wed, 4 Apr 2001 06:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDDKUX>; Wed, 4 Apr 2001 06:20:23 -0400
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:57472 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S132776AbRDDKUL>; Wed, 4 Apr 2001 06:20:11 -0400
Date: Wed, 4 Apr 2001 12:18:52 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Harald Dunkel <harri@synopsys.COM>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: ReiserFS? How reliable is it? Is this the future?
Message-ID: <20010404121852.A2284@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>; from harri@synopsys.COM on Tue, Apr 03, 2001 at 02:13:14PM +0200
X-Uptime: 12:07:48 up 12:54,  5 users,  load average: 0.16, 0.04, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald,

> If I get the DVD stuff working, then I won't need NT anymore, i.e.
> I will have an empty disk.
> 
> What is your impression about ReiserFS? Does it work? Is it stable
> enough for my daily work, or is it something to try out and watch
> carefully? Do you use ReiserFS for your boot partition?
> 
> Or should I try ext3 instead?

For me it is very stable on several servers and workstations, and for
quite some time now (since the kernel 2.3 series, had to watch the lists
for faulty combinations though). I never used kernel 2.2 with reiserfs
(3.5), but only 2.3 and 2.4 (and thus rfs 3.6). My newest workstation
and notebook have one partition (/) and thus reiserfs is root and boot
partition. On older ones it was necessary to have a small /boot
partition because of an older version of lilo. It is no use to have
reiserfs on /boot if it is small (which usually is the case), due to the
journal which is 32 meg.
The bigest point so far where the fsck tools, but they seem to be quite
usefull these days, and under active development.

	Ookhoi
