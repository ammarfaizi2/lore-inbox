Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVHKUe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVHKUe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVHKUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:34:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42920 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932442AbVHKUez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:34:55 -0400
Message-ID: <42FBB66C.3020008@pobox.com>
Date: Thu, 11 Aug 2005 16:34:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dick <dm@chello.nl>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: How to put an ata_piix (SATA) harddisk to sleep/standby
References: <loom.20050811T214109-933@post.gmane.org>
In-Reply-To: <loom.20050811T214109-933@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick wrote:
> How do I put an SATA ata_piix harddisk to sleep?
> 
> I've tried blktool, hdparm and sdparm but none seem to work, does it need a
> special ioctl or should I patch something?

Apply the ATA passthru patch, or grab the latest 'upstream' branch of 
libata-dev.git and use the SCSI START STOP UNIT change I checked in last 
night.

	Jeff



