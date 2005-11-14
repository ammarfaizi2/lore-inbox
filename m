Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVKNPWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVKNPWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVKNPWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:22:19 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:46468 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751150AbVKNPWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:22:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] Silence warning in cciss_scsi
Date: Mon, 14 Nov 2005 09:22:17 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10B233643@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] Silence warning in cciss_scsi
Thread-Index: AcXnWPJfSX/Yi98MTK2SgGThHCneHQB1i3Qw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: <gcoady@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Nov 2005 15:22:17.0979 (UTC) FILETIME=[3316BCB0:01C5E92F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Grant Coady [mailto:grant_lkml@dodo.com.au] 
> Sent: Friday, November 11, 2005 10:46 PM
> To: Miller, Mike (OS Dev)
> Cc: Andrew Morton; linux-kernel@vger.kernel.org
> Subject: [RFC PATCH] Silence warning in cciss_scsi
> 
> Greetings,
> 
> From: Grant Coady <gcoady@gmail.com>
> 
> Silence warning due to all callers being commented out:
> drivers/block/cciss_scsi.c:264: warning: `print_bytes' 
> defined but not used
> drivers/block/cciss_scsi.c:298: warning: `print_cmd' defined 
> but not used
> 
> compile tested with allmodconfig
> 
> Signed-off-by: Grant Coady <gcoady@gmail.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> ---
>  cciss_scsi.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.15-rc1a/drivers/block/cciss_scsi.c~	
> 2005-11-12 13:51:12.000000000 +1100
> +++ linux-2.6.15-rc1a/drivers/block/cciss_scsi.c	
> 2005-11-12 15:36:01.000000000 +1100
> @@ -255,7 +255,7 @@
>  #define DEVICETYPE(n) (n<0 || n>MAX_SCSI_DEVICE_CODE) ? \
>  	"Unknown" : scsi_device_types[n]
>  
> -#if 1
> +#if 0
>  static int xmargin=8;
>  static int amargin=60;
>  
> --
> Thanks,
> Grant.
> 
