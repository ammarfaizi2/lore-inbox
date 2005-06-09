Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVFIGMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVFIGMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVFIGMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:12:35 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:61392 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262294AbVFIGL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:11:27 -0400
Subject: Re: Performance figure for sx8 driver -- More information
From: Kallol Biswas <kallol@nucleodyne.com>
Reply-To: kallol@nucleodyne.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
References: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
Content-Type: text/plain
Organization: NucleoDyne Systems Inc.
Message-Id: <1118297512.9632.2.camel@driver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Jun 2005 23:11:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux driver from Promise gets much better performance than sx8
on 2.6.6 (back port) kernel. The 2.6 Promise driver uses SCSI framework.

On Wed, 2005-06-08 at 18:24, kallol@nucleodyne.com wrote:
> Does anyone have performace figure for sx8 driver which is for promise SATAII150
> 8 port PCI-X adapter?
> 
> Someone reports that on a platform with sx8 driver, multiple hdparms on
> different disks those are connected to the same adapter (there are 8 ports) can
> not get more than 45MB/sec in total, whereas a SCSI based driver for the same
> adapter gets around 150MB/sec.
> 
> Any comment on this?
> 
> 
> Kallol Biswas
> www.nucleodyne.com
> kallol@nucleodyne.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

