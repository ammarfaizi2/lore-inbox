Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVJaL0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJaL0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVJaL0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:26:21 -0500
Received: from mail.dvmed.net ([216.237.124.58]:4750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750791AbVJaL0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:26:21 -0500
Message-ID: <4365FF53.8000707@pobox.com>
Date: Mon, 31 Oct 2005 06:26:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: linux-kernel@vger.kernel.org, Mark Tomich <tomichm@bellsouth.net>
Subject: Re: patch to add a config option to enable SATA ATAPI by default
References: <1130691328.8303.8.camel@localhost> <20051031102723.GA10037@suse.de>
In-Reply-To: <20051031102723.GA10037@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
>  On Sun, Oct 30, Mark Tomich wrote:
> 
> 
>>Below is a very straight-forward patch to add a config option to
>>enabling SATA ATAPI by default.
> 
> 
>>diff -u -r linux-2.6.14-rc5/drivers/scsi/Kconfig
>>linux-2.6.14-rc5-patched/drivers/scsi/Kconfig
>>--- linux-2.6.14-rc5/drivers/scsi/Kconfig	2005-10-30 11:09:15.533533419 -0500
>>+++ linux-2.6.14-rc5-patched/drivers/scsi/Kconfig	2005-10-30 11:21:39.735696058 -0500
>>@@ -445,6 +445,17 @@
>> 
>> 	  If unsure, say N.
>> 
>>+config SCSI_SATA_ENABLE_ATAPI
>>+	bool "Enable SATA ATAPI by default"
> 
> 
> Jeff, will you apply this?

Nope.  It's already a runtime option.  The runtime option will default 
to enabled when ATAPI is working 100%.

	Jeff



