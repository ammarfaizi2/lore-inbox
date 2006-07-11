Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWGKPaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWGKPaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWGKPaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:30:04 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:27343 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751286AbWGKPaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:30:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/block/cpqarray.c: remove an unused variable
Date: Tue, 11 Jul 2006 10:29:59 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE5524A6E5@cceexc23.americas.cpqcorp.net>
In-Reply-To: <20060711141626.GP13938@stusta.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/block/cpqarray.c: remove an unused variable
Thread-Index: Acak9KBvHI33fPeBQfKFm56WQ5WrnQACi9XA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <chirag.kantharia@hp.com>, "ISS StorageDev" <iss_storagedev@hp.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jul 2006 15:30:00.0110 (UTC) FILETIME=[DF4494E0:01C6A4FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@stusta.de] 
> Sent: Tuesday, July 11, 2006 9:16 AM
> To: Andrew Morton
> Cc: chirag.kantharia@hp.com; ISS StorageDev; 
> linux-kernel@vger.kernel.org
> Subject: [2.6 patch] drivers/block/cpqarray.c: remove an 
> unused variable
> 
> This patch removes a no longer used variable.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> ---
> 
> This patch was already sent on:
> - 8 Jul 2006
> 
> --- linux-2.6.17-mm6-full/drivers/block/cpqarray.c.old	
> 2006-07-06 23:56:36.000000000 +0200
> +++ linux-2.6.17-mm6-full/drivers/block/cpqarray.c	
> 2006-07-06 23:56:15.000000000 +0200
> @@ -1739,8 +1739,6 @@
>  	     (log_index < id_ctlr_buf->nr_drvs)
>  	     && (log_unit < NWD);
>  	     log_unit++) {
> -		struct gendisk *disk = ida_gendisk[ctlr][log_unit];
> -
>  		size = sizeof(sense_log_drv_stat_t);
>  
>  		/*
> 
> 
