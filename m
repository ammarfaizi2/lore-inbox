Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUKETEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUKETEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKETEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:04:12 -0500
Received: from wasp.net.au ([203.190.192.17]:44516 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261163AbUKETEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:04:07 -0500
Message-ID: <418BCED3.1030600@wasp.net.au>
Date: Fri, 05 Nov 2004 23:04:51 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8+ (X11/20041029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [SATA] status report, libata-dev queue updated
References: <20041105100049.GA31653@havoc.gtf.org>
In-Reply-To: <20041105100049.GA31653@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> <andyw:pobox.com>:
>   o [libata scsi] support 12-byte passthru CDB
>   o [libata scsi] passthru CDB check condition processing
>   o T10/04-262 ATA pass thru - patch
> 
> 
> John W. Linville:
>   o libata: SMART support via ATA pass-thru

I'll just add a big ack for these two patches. I have been using these extensively now for a couple 
of weeks on a 14 drive array spread over 12 Maxtor Drives on Promise SATA150TX4 Controllers and 1 
WD2500BB on a VIA controller by way of an SIL PATA->SATA bridge polling all drives hourly for full 
SMART stats and running daily self tests while also testing heavy drive usage patterns and manual 
SMART polling and have not encountered any data corruption.

Read that as "I have tried really, really hard to break it and as yet been unable to".

Regards,
Brad
