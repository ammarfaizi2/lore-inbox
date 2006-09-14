Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWINTTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWINTTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWINTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:19:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52684 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751059AbWINTTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:19:14 -0400
Message-ID: <4509AB2E.1030800@garzik.org>
Date: Thu, 14 Sep 2006 15:19:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Robin H. Johnson" <robbat2@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net>
In-Reply-To: <20060914200500.GD27531@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin H. Johnson wrote:
> [Please CC me, I'm not subscribed.]
> 
> Recently picked up some new hardware (without sufficiently researching
> it), and I have found that the AHCI driver does NOT see my SATA optical
> device at all.

> scsi1 : ahci
> ata1: SATA link down (SStatus 0 SControl 300)
> scsi2 : ahci
> ata2: SATA link down (SStatus 0 SControl 300)
> scsi3 : ahci
> ata3: SATA link down (SStatus 0 SControl 0)
> scsi4 : ahci
> ata4: SATA link down (SStatus 0 SControl 0)


Unfortunately the SATA phy isn't showing that a SATA device (hd or cdrom 
or anything) is connected.  So can't do anything much at all, if that is 
the case.

Perhaps re-check all the power connections, cables, etc.

	Jeff


