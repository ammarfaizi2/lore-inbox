Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRHANLo>; Wed, 1 Aug 2001 09:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266974AbRHANLf>; Wed, 1 Aug 2001 09:11:35 -0400
Received: from matrix.fr.professo.net ([213.11.43.1]:32778 "EHLO
	fr.professo.net") by vger.kernel.org with ESMTP id <S266970AbRHANLV>;
	Wed, 1 Aug 2001 09:11:21 -0400
Message-ID: <023c01c11a8b$79a1aea0$c200a8c0@professo.lan>
From: "Ghozlane Toumi" <gtoumi@messel.emse.fr>
To: "lkml" <linux-kernel@vger.kernel.org>,
        "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: released FB driver for 3Dfx Voodoo1/2
Date: Wed, 1 Aug 2001 15:11:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
At last I took time to release a more or less working version of sstfb,
a driver for the old/dead but once famous 3Dfx 3D "only" chips, namely
the voodoo graphics and the voodoo2 .

A small problem (basicaly awfully outdated an unmaitained machine , my
fault) did'nt allow me to test it myself with 2.4 kernels , but i have a
very
good tester, and it seems that the driver works more or less with 2.4, with
some issues: when using X fbdev 4 (on linux2.4), killing X may oops, and
lives the console with strange palette (in addition to strange colors in
windows border colors).
(a reminder that this driver is still experimental) .

On 2.2.19 everything looks ok, even with X.
(Well, at least an X from the 3.3.x awfully old fame).

I'm trying to investigate the problems, but as I'm unable to reproduce
myself, it's not that easy. The next step is rebuilding my machine with
an up-to-date distribution and take a look at the 2.4 / X4 issues.

Meanwhile, the latest "kinda stable" (read no oops/crash on my box)
version is avaiable for 2.2.19, 2.4.7 and 2.4.7-ac3 on sourceforge :
http://prdownloads.sourceforge.net/sstfb/sstfb-20010801.tgz .
for the patches only , look at the download page directly :
http://sourceforge.net/projects/sstfb/files .

I'm looking for good willing people to take a look at the driver and flame
me at sight, and if i'm lucky, I'd like to increase a little bit the testing
base for the thing (3 testers + me so far)
Thank you very much ,

ghoz

PS please CC me on eventual replies as I may not be able to follow the
lists in the folowing days

