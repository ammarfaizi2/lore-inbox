Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318744AbSHSMoD>; Mon, 19 Aug 2002 08:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSHSMoD>; Mon, 19 Aug 2002 08:44:03 -0400
Received: from smtp03.web.de ([217.72.192.158]:46853 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318744AbSHSMoD>;
	Mon, 19 Aug 2002 08:44:03 -0400
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre3 boot hang
References: <20020818153145.GA3184@df1tlpc.local.here>
	<87vg6811p6.fsf@plailis.homelinux.net>
	<1029694978.16822.10.camel@irongate.swansea.linux.org.uk>
	<87r8gv702r.fsf@plailis.homelinux.net>
	<1029759525.19375.3.camel@irongate.swansea.linux.org.uk>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Mon, 19 Aug 2002 14:46:28 +0200
In-Reply-To: <1029759525.19375.3.camel@irongate.swansea.linux.org.uk> (Alan
 Cox's message of "19 Aug 2002 13:18:45 +0100")
Message-ID: <87vg67aue3.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

* Alan Cox writes:
>Ok thanks. That one does tell me something useful. The scsi layer (most
>likely ide-scsi itself) passed down a buffer that did not have a valid
>mapping.

>Do you have Highmem/highio enabled ?

Nope, neither of them.

regards
Markus

