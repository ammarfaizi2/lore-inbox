Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135772AbRD2NC2>; Sun, 29 Apr 2001 09:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135771AbRD2NCR>; Sun, 29 Apr 2001 09:02:17 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:45298 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S135770AbRD2NCK>; Sun, 29 Apr 2001 09:02:10 -0400
Message-Id: <l03130304b711bfd8bac3@[192.168.239.105]>
In-Reply-To: <20010429123454.364E06808@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 29 Apr 2001 14:00:04 +0100
To: klink@clouddancer.com, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: OOM stupidity
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Where is a patch to allow the sensible OOM I had in prior kernels?
>(cause this crap is getting pitched)

I gave Alan a patch to fix the problem where the OOM activates too early
(eg. when there's still plenty of swap and buffer memory to eat).  I don't
know whether this made it into the mainstream kernel, but from the sound of
it, it didn't.

I also did some work on the OOM killer itself (so that it tries to be more
intelligent about *what* it kills), and I'm fairly certain that didn't get
accepted.

If you like, I can post a patch containing these two fixes.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


