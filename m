Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTABIKK>; Thu, 2 Jan 2003 03:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTABIKK>; Thu, 2 Jan 2003 03:10:10 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:17055 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266199AbTABIKK>; Thu, 2 Jan 2003 03:10:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi CD-recorder error reading burned disks
References: <Pine.LNX.4.44.0301012323220.3378-100000@poirot.grange>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Thu, 02 Jan 2003 09:17:18 +0100
In-Reply-To: <Pine.LNX.4.44.0301012323220.3378-100000@poirot.grange> (Guennadi
 Liakhovetski's message of "Wed, 1 Jan 2003 23:55:30 +0100 (CET)")
Message-ID: <87ptrgynht.fsf@web.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Guennadi Liakhovetski writes:
>I used -isosize (copying from another CD), which has an effect similar
>to -pad. Just tried with -pad - same. -dao, as suggested by Kasper
>Dupont <kasperd@daimi.au.dk>, doesn't help either. On the contrary, the
>latter makes the error appear in all 3 reads - ide-scsi, ide, scsi (I
>used it together with -isosize). Also strange, the number of blocks
>read by dd bs=2048 on ide and scsi from the same disk differ...

Try -raw. Some drives (e.g. my acer 2010A) have - according to Joerg
Schilling - broken firmwares, that have problems in SAO mode.

regards
Markus

