Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWHXJAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWHXJAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWHXJAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:00:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42731 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750861AbWHXJAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:00:23 -0400
Message-ID: <44ED6AA2.2080306@garzik.org>
Date: Thu, 24 Aug 2006 05:00:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] libata fixes
References: <20060824081336.GA15502@havoc.gtf.org> <20060824082954.GA9315@kroah.com>
In-Reply-To: <20060824082954.GA9315@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 24, 2006 at 04:13:36AM -0400, Jeff Garzik wrote:
>> Please pull from 'upstream-greg' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg
>>
>> to receive the following updates:
>>
>>  drivers/scsi/ata_piix.c    |   84 +++++++++++++++++++++++++-------
>>  drivers/scsi/libata-core.c |    2 
>>  drivers/scsi/pdc_adma.c    |    3 -
>>  drivers/scsi/sata_via.c    |  117 +++++++++++++++++++++++++++++++++++++++++++--
>>  4 files changed, 180 insertions(+), 26 deletions(-)
> 
> Pulled from, and pushed out.  Is this set of patches supposed to fix my
> ata_piix cdrom problem for my laptop?  I'll go build and test to see if
> it does or not...

It should, yes.

You can twiddle with the force_pcs module option if things are still wonky.

	Jeff



