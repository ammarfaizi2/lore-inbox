Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269896AbUJMWpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269896AbUJMWpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269890AbUJMWmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:42:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46018 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269893AbUJMWlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:41:44 -0400
Message-ID: <416DAF1A.2040204@pobox.com>
Date: Wed, 13 Oct 2004 18:41:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca> <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca>
In-Reply-To: <416DA951.2090104@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> The change would be as follows:  Export ata_scsi_simulate(),
> and replace the first two parameters (struct ata_port, struct ata_device)
> with a pointer to the 512-byte drive IDENTIFY response data.


Fine with me but you'll need more than just the identify data, if you 
wanna do stuff like support MODE SELECT/SENSE.

	Jeff


