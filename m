Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbTATNcu>; Mon, 20 Jan 2003 08:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbTATNct>; Mon, 20 Jan 2003 08:32:49 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:49115 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265828AbTATNcn>; Mon, 20 Jan 2003 08:32:43 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: CD Changer
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Mon, 20 Jan 2003 14:39:24 +0100
In-Reply-To: <011501c2c087$17f511d0$0500000b@shiva.com> ("Alexandre April"'s
 message of "Mon, 20 Jan 2003 08:23:17 -0500")
Message-ID: <8765skos8j.fsf@web.de>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.3.50
 (i686-pc-linux-gnu)
References: <002c01c2c001$f36db9f0$0a01a8c0@aaprilhome>
	<20030120072329.GI30184@lug-owl.de>
	<00d201c2c083$5aceb460$0500000b@shiva.com>
	<20030120131924.GO30184@lug-owl.de>
	<011501c2c087$17f511d0$0500000b@shiva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexandre April writes:
>Well I tried using ide-scsi for the CD changer device but without your
>"Scan all LUNs" and it showed only one device so I suppose if I turn
>that switch on I'll probably gonna see all 4 cd in different LUNs.

>Do you have the exact swicth for Scan all LUNs ?

[plail@plailis_lfs]grep LUN /usr/src/linux/.config
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
# CONFIG_SCSI_MULTI_LUN is not set

SCSI support -> Probe all LUNs on each SCSI device

HTH
Markus

