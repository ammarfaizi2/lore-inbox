Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbTFASHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTFASHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:07:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:34541 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264693AbTFASG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:06:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord and 2.5 kernels
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <8765nqnvyv.fsf@gitteundmarkus.de>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Sun, 01 Jun 2003 20:21:02 +0200
In-Reply-To: <8765nqnvyv.fsf@gitteundmarkus.de> (Markus Plail's message of
 "Sun, 01 Jun 2003 08:38:32 +0200")
Message-ID: <87y90lveup.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jun 2003, Markus Plail wrote:

> I just compiled a few kernels and realized that 2.5.45 was the kernel
> that broke writing DVD/CD-Rs for me. The messages at the bottom are
> from 2.5.70 plus the second sg_io patch.

And now I realized something even more strange: My old acer writer
works just fine with 2.5.70 and ide-cd.
Both work fine when I use ide-scsi. I also swapped the drives to see if
it's a problem with the cabling or the order in which they are
connected to the bus. Nothing changed.
Also with 2.5.44, where I don't get the same error, the TEAC doesn't
work 100% either. Burning a CD-R with it, which should be possible at
max. 16x I get a speed about 67x, both with cdrdao and cdrecord. The so
burned CD-R aren't readable.

regards
Markus

