Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031440AbWFOVd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031440AbWFOVd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031448AbWFOVd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 17:33:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:39055 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031440AbWFOVd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 17:33:57 -0400
Message-ID: <4491D241.3040506@garzik.org>
Date: Thu, 15 Jun 2006 17:33:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Gord Peters <GordPeters@smarttech.com>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: SATA: Marvell 88SE6141 support?
References: <A6F7DE24-36C7-4FDB-AB2A-2C63478F0D0A@smarttech.com> <44916C5B.5000402@rtr.ca> <44917BFE.1070604@garzik.org> <4491A90E.8010702@rtr.ca> <5351048D-59BA-4348-BB35-BDFFD3622BE8@smarttech.com>
In-Reply-To: <5351048D-59BA-4348-BB35-BDFFD3622BE8@smarttech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gord Peters wrote:
> At first I thought that only the Marvell SATA ports could be used for a 
> RAID (based on how they're labeled in the manual), but now I see that 
> either set of SATA ports can be used for RAID.  So I may be able to set 
> my RAID up using the ICH7R based ports until the Marvell chip is 
> supported.  Am I correct to believe that the Intel ICH7R chip is 
> supported in 2.6.16?


Neither are hardware RAID.  It's usually better to just use OS RAID.

	Jeff


