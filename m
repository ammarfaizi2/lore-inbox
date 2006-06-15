Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWFOOkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWFOOkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWFOOkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:40:42 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:34758 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030452AbWFOOkl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:40:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 5/7] CCISS: fix a few spelling errors
Date: Thu, 15 Jun 2006 09:40:39 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10C5249E4@cceexc23.americas.cpqcorp.net>
In-Reply-To: <200606141711.38975.bjorn.helgaas@hp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/7] CCISS: fix a few spelling errors
Thread-Index: AcaQB/EbN93/DG0MTVuscOGIOHhtxwAgaxjA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 15 Jun 2006 14:40:40.0606 (UTC) FILETIME=[AC869BE0:01C69089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Helgaas, Bjorn 
> Sent: Wednesday, June 14, 2006 6:12 PM
> To: Miller, Mike (OS Dev)
> Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
> Subject: [PATCH 5/7] CCISS: fix a few spelling errors
> 
> Fix a few spelling errors.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> Index: rc5-mm3/drivers/block/cciss.c
> ===================================================================
> --- rc5-mm3.orig/drivers/block/cciss.c	2006-06-14 
> 15:16:13.000000000 -0600
> +++ rc5-mm3/drivers/block/cciss.c	2006-06-14 
> 15:16:44.000000000 -0600
> @@ -129,7 +129,7 @@
>  	{ 0x3215103C, "Smart Array E200i", &SA5_access},  };
>  
> -/* How long to wait (in millesconds) for board to go into 
> simple mode */
> +/* How long to wait (in milliseconds) for board to go into 
> simple mode 
> +*/
>  #define MAX_CONFIG_WAIT 30000
>  #define MAX_IOCTL_CONFIG_WAIT 1000
>  
> @@ -1117,7 +1117,7 @@
>   *
>   * Right now I'm using the getgeometry() function to do 
> this, but this
>   * function should probably be finer grained and allow you 
> to revalidate one
> - * particualar logical volume (instead of all of them on a particular
> + * particular logical volume (instead of all of them on a particular
>   * controller).
>   */
>  static int revalidate_allvol(ctlr_info_t *host) @@ -1260,7 +1260,7 @@
>  		return;
>  
>  
> -	/* Get information about the disk and modify the driver 
> sturcture */
> +	/* Get information about the disk and modify the driver 
> structure */
>  	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
>          if (size_buff == NULL)
>  		goto mem_msg;
> @@ -1335,7 +1335,7 @@
>  }
>  
>  /* This function will add and remove logical drives from the Logical
> - * drive array of the controller and maintain persistancy of ordering
> + * drive array of the controller and maintain persistency of ordering
>   * so that mount points are preserved until the next reboot. 
>  This allows
>   * for the removal of logical drives in the middle of the drive array
>   * without a re-ordering of those drives.
> @@ -1482,7 +1482,7 @@
>   * clear_all = This flag determines whether or not the disk 
> information
>   *             is going to be completely cleared out and the 
> highest_lun
>   *             reset.  Sometimes we want to clear out 
> information about
> - *             the disk in preperation for re-adding it.  In 
> this case
> + *             the disk in preparation for re-adding it.  In 
> this case
>   *             the highest_lun should be left unchanged and the LunID
>   *             should not be cleared.
>  */
> @@ -2597,7 +2597,7 @@
>  	return IRQ_HANDLED;
>  }
>  /*
> - *  We cannot read the structure directly, for portablity we 
> must use 
> + *  We cannot read the structure directly, for portability 
> we must use
>   *   the io functions.
>   *   This is for debug only. 
>   */
> @@ -2620,9 +2620,9 @@
>  				readl(&(tb->TransportActive)));
>  	printk("   Requested transport Method = 0x%x\n", 
>  			readl(&(tb->HostWrite.TransportRequest)));
> -	printk("   Coalese Interrupt Delay = 0x%x\n", 
> +	printk("   Coalesce Interrupt Delay = 0x%x\n", 
>  			readl(&(tb->HostWrite.CoalIntDelay)));
> -	printk("   Coalese Interrupt Count = 0x%x\n", 
> +	printk("   Coalesce Interrupt Count = 0x%x\n", 
>  			readl(&(tb->HostWrite.CoalIntCount)));
>  	printk("   Max outstanding commands = 0x%d\n", 
>  			readl(&(tb->CmdsOutMax)));
> 
