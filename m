Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269916AbUJMXkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269916AbUJMXkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269923AbUJMXjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:39:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269937AbUJMXjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:39:15 -0400
Message-ID: <416DBC96.2090602@pobox.com>
Date: Wed, 13 Oct 2004 19:39:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca> <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca> <416DAF1A.2040204@pobox.com> <416DB912.7040805@rtr.ca>
In-Reply-To: <416DB912.7040805@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Fine with me but you'll need more than just the identify data, if you 
>> wanna do stuff like support MODE SELECT/SENSE.
> 
> 
> QStor has no need for MODE_SELECT, and the current implementation
> of MODE_SENSE in libata-scsi appears to use only the IDENTIFY data.
> 
> The READ_CAPACITY emulation in libata-scsi currently uses dev->n_sectors,
> but that could be changed to recalculate it from the IDENTIFY words.
> 
> So.. okay in concept?

Seems sane, send a patch.

Typically we aren't in the business of pre-approving patches, much to 
ESR's chagrin :)

	Jeff


