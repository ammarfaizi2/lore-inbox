Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRJPUF5>; Tue, 16 Oct 2001 16:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276669AbRJPUFt>; Tue, 16 Oct 2001 16:05:49 -0400
Received: from mout01.kundenserver.de ([195.20.224.132]:23076 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276665AbRJPUFo>; Tue, 16 Oct 2001 16:05:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: Ryan Sweet <rsweet@atos-group.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: random reboots of diskless nodes - 2.4.7 (fwd)
Date: Tue, 16 Oct 2001 22:06:09 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.30.0110160228000.18043-100000@core-0>
In-Reply-To: <Pine.LNX.4.30.0110160228000.18043-100000@core-0>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011016200610.D56BBF6A@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 16. October 2001 02:28, Ryan Sweet wrote:

[..]

> The nodes mount the root as nfsv2 because if I mount as v3 they
> inevitably fall over and _don't re-boot_.  All other mounts are as v3.

May have a look in this one, it took me some time to figure out, how
to mount root at v3 (",v3" appended to --rootdir option of mknbi-linux)
Since then, I see far less problems here.

FYI: I'm using 2.4.5 + trond's patches on a wide range (AMD K6/200, P2/350, 
P3/600, AMD K7/1200, 128-768 MB, all asus + 3c90* + mga*) of diskless WSs 
here. I'm writing this on a 1.2g with pristine 2.4.12 and it feels fine, too 
(2d, 3:51 up). A couple of .9/.10-ac? releases gave some sluggish vm 
behaviour, though. OTOH, I'm using reiserfs on the server (2.4.7) with some 
patches, not xfs. But will give xfs a try on a server test config by the end 
of this week on a dual K7 XP1700+ ;-) 

To my experience, it's important to put enough ram into the boxes, since
I couldn't get them to swap via nbd. They usually run a full featured KDE2 
environment, StarOffice 5.2, vmware, IOW: all this heavy stuff with heavy 
regaled users ;-)

Server1:# uptime
  9:54pm  up 75 days,  3:24,  1 user,  load average: 0.00, 0.00, 0.00
Server1:# uname -a
Linux xyzzy 2.4.6 #20 SMP Mon Jul 23 22:24:14 CEST 2001 i686 unknown
HW: Dual Intel P3-900/Serverworks OSB4/ICP Raid GDT 7x38RN/Yellofin Gnic2

Read you,
Hans-Peter
