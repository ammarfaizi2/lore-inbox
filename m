Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVCHArN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVCHArN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVCHAn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:43:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41915 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261174AbVCHAmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:42:33 -0500
Message-ID: <422CF4CF.4070905@pobox.com>
Date: Mon, 07 Mar 2005 19:41:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aurelien Jarno <aurelien@aurel32.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] 2.6.x libata updates
References: <422C8B64.1020404@pobox.com> <20050308003329.GA21516@bode.aurel32.net>
In-Reply-To: <20050308003329.GA21516@bode.aurel32.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno wrote:
> On Mon, Mar 07, 2005 at 12:12:04PM -0500, Jeff Garzik wrote:
> 
> 
>>Please do a
>>
>>	bk pull bk://gkernel.bkbits.net/libata-2.6
>>
>>This will update the following files:
>>
>> drivers/scsi/libata-core.c |   16 ++++++----------
>> drivers/scsi/sata_nv.c     |    6 ++++--
>> drivers/scsi/sata_sil.c    |    2 +-
>> drivers/scsi/sata_svw.c    |    4 ++--
>> drivers/scsi/sata_vsc.c    |    3 ++-
>> 5 files changed, 15 insertions(+), 16 deletions(-)
>>
>>through these ChangeSets:
>>
>>Adam J. Richter:
>>  o ata_pci_remove_one used freed memory
>>
>>Adrian Bunk:
>>  o drivers/scsi/sata_*: make code static
>>
> 
> Is there any plan to include the ATA pass thru functionality into the main
> kernel tree?

When the SCSI opcodes are standardized (sometime this month), and a few 
final locking/sync issues looked into.

	Jeff



