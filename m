Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTBQRP0>; Mon, 17 Feb 2003 12:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTBQRP0>; Mon, 17 Feb 2003 12:15:26 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:59611 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267179AbTBQRPZ>; Mon, 17 Feb 2003 12:15:25 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 clings to you like flypaper
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Mon, 17 Feb 2003 18:21:55 +0100
In-Reply-To: <20030217170851.GA18693@wohnheim.fh-wedel.de>
 =?iso-8859-1?q?(J=F6rn?= Engel's message of "Mon, 17 Feb 2003 18:08:51
 +0100")
Message-ID: <87el66zuto.fsf@web.de>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.3.50
 (i686-pc-linux-gnu)
References: <78320000.1045465489@[10.10.2.4]>
	<1045482621.29000.40.camel@passion.cambridge.redhat.com>
	<2460000.1045500532@[10.10.2.4]>
	<20030217170851.GA18693@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Jörn Engel wrote:

> This is, how things worked for me:
> 1. Kernel tries to mount rootfs ext3. If this fails, it will continue
> trying ext2. No other fs compiled into kernel.
> 2. If there is a journal, it is ext3.
> 3. Init scripts read /etc/fstab and read ext2.
> 4. root is remounted as ext2.
                          ^^^^ It looks like it is remounted as ext2,
but it's really ext3. mount says ext2, but 'cat /proc/mounts' reveals
it's still ext3. Have been bitten by that once, too.

regards
Markus


