Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVBLUvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVBLUvd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 15:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBLUvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 15:51:33 -0500
Received: from bender.bawue.de ([193.7.176.20]:57227 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261200AbVBLUvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 15:51:18 -0500
Date: Sat, 12 Feb 2005 21:51:11 +0100
From: Joerg Sommrey <jo@sommrey.de>
Message-Id: <200502122051.j1CKpBds020978@bear.sommrey.de>
To: jgarzik@pobox.com, jr@xor.at, linux-kernel@vger.kernel.org
Subject: Re: Problem on SATA-disk with Promise SATAII 150 TX4 ("DriveReady SeekComplete Error")
References: <3w4M1-61S-27@gated-at.bofh.it> <3wS5k-5H5-13@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote::
>Johannes Resch wrote:
>> Hi,
>> 
>> [please CC me on replies]
>> 
>> I've got a box running 2.6.10 (with the patch[0] needed to support the 
>> Promise SATAII 150 TX4 controller).
>> This box has three software raid1 partitions mirrored on a SATA disk on 
>> the Promise controller and a disk on the mainboard IDE controller (VIA 
>> vt8235).
>> 
>> Within 4 days running the raid1, I got those three errors pasted below, 
>> each marking the SATA-raidmember as faulty. After "raidhotremove" and 
>> "raidhotadd" the SATA-raidmember syncs again fine and works at least a 
>> day until it is marked as faulty again.
>> 
>> Any pointers where I could look at to resolve this problem?
>> The SATA drive is a new Seagate ST3250823AS.

>I would change out your cables, and also make sure you are running 
>2.6.11-rc3-bk-latest, which includes all the SATAII patches and other fixes.

I don't believe it has anything to do with cabling.  2.6.10-ac9 introduced
some sata patches.  I didn't check -ac9 and -ac10, but -ac11 and -ac12 are
not usable on my box with exactly the same symptoms.

-jo
-- 
-rw-r--r--  1 jo users 63 2005-02-12 18:43 /home/jo/.signature
