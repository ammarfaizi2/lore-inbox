Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752051AbWHNS2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWHNS2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWHNS2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:28:23 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752051AbWHNS2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:28:22 -0400
Message-ID: <44E0C0BC.7020509@pobox.com>
Date: Mon, 14 Aug 2006 14:28:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [-mm patch] cleanup drivers/ata/Kconfig
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813210106.GO3543@stusta.de>
In-Reply-To: <20060813210106.GO3543@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.18-rc3-mm2:
>> ...
>>  git-libata-all.patch
>> ...
>>  git trees
>> ...
> 
> This patch contains the following cleanups:
> - create a menu for ATA
> - replace the dependencies on ATA with an "if ATA"
>   as a side effect, this fixes a menu breakage due to SATA_INTEL_COMBINED
> - fix a typo in the PATA_OPTIDMA prompt
> - let ATA selet SCSI instead of depending on SCSI
>   this should make it easier for users to enable ATA (similar to USB_STORAGE)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

There have been a bunch of more-important changes to this file.  Please 
wait until Andrew pulls from me, and resend.

Thanks,

	Jeff



