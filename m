Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTFAJFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFAJFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 05:05:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:22470 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262221AbTFAJF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 05:05:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20030530130230.GD813@suse.de> <878ysopmus.fsf@gitteundmarkus.de>
	<874r3cpmmv.fsf@gitteundmarkus.de> <20030530145845.GI813@suse.de>
	<87u1bcs789.fsf@gitteundmarkus.de>
	<20030601075021.GA3042@pusa.informat.uv.es>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Sun, 01 Jun 2003 11:18:52 +0200
In-Reply-To: <20030601075021.GA3042@pusa.informat.uv.es> (uaca@alumni.uv.es's
 message of "Sun, 1 Jun 2003 09:50:21 +0200")
Message-ID: <87n0h2m9z7.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, uaca@alumni.uv.es wrote:

> I tested 2.5.70 with scsi-ioctl-2 patch
> 
> It works fine until It has to read the last sectors.
> I get the following messages from readcd, using different CD-Rs

This is just normal. Either the CD-Rs are burned in TAO mode or your
writer has problems with DAO (mine has the same problems). See
README.verify. Every such disc has two unreadable "run-out" sectors. If
this happens with -dao, try -raw96r.

HTH
Markus

BTW: Can you successsfully burn CD-Rs with > 2.5.45? If so, could you
send me your .config please?

