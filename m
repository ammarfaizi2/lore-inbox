Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVBKXFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVBKXFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVBKXFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:05:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31696 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262175AbVBKXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:05:29 -0500
Message-ID: <420D3A2B.3000103@pobox.com>
Date: Fri, 11 Feb 2005 18:05:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Resch <jr@xor.at>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problem on SATA-disk with Promise SATAII 150 TX4 ("DriveReady
 SeekComplete Error")
References: <420A547A.4000008@xor.at>
In-Reply-To: <420A547A.4000008@xor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Resch wrote:
> Hi,
> 
> [please CC me on replies]
> 
> I've got a box running 2.6.10 (with the patch[0] needed to support the 
> Promise SATAII 150 TX4 controller).
> This box has three software raid1 partitions mirrored on a SATA disk on 
> the Promise controller and a disk on the mainboard IDE controller (VIA 
> vt8235).
> 
> Within 4 days running the raid1, I got those three errors pasted below, 
> each marking the SATA-raidmember as faulty. After "raidhotremove" and 
> "raidhotadd" the SATA-raidmember syncs again fine and works at least a 
> day until it is marked as faulty again.
> 
> Any pointers where I could look at to resolve this problem?
> The SATA drive is a new Seagate ST3250823AS.

I would change out your cables, and also make sure you are running 
2.6.11-rc3-bk-latest, which includes all the SATAII patches and other fixes.

	JEff



