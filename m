Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTGTKJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTGTKJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:09:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:44526 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263930AbTGTKJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:09:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: how to use "ATAPI:" protocol for IDE CD/RWs??
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Sun, 20 Jul 2003 12:24:49 +0200
In-Reply-To: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain> (Robert
 P. J. Day's message of "Sun, 20 Jul 2003 06:08:30 -0400 (EDT)")
Message-ID: <87d6g51oni.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003, Robert P. J. Day wrote:
> are there known problems with trying to access IDE CD/RWs directly
> through the IDE drivers, rather than using SCSI emulation?  i've tried
> testing cdrecord using the "dev=ATAPI:x,y,z" option, and am having
> no luck.

If you don't have ide-scsi emulation, use dev=dev/hdX
I never really understood what ATAPI: is for. Presumably you need it
for PCATA found in notebooks.

regards
Markus

