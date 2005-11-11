Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVKKDvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVKKDvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVKKDvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:51:55 -0500
Received: from emulex.emulex.com ([138.239.112.1]:62651 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S932348AbVKKDvy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:51:54 -0500
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: [PATCH] lpfc build fix
Date: Thu, 10 Nov 2005 22:51:31 -0500
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C2276B53@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lpfc build fix
Thread-Index: AcXmYAyhjcpb9lF5SKORMAz30FaQwQAExOJQ
To: <jgarzik@pobox.com>, <akpm@osdl.org>, <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok...

-- james s

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org
> [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of Jeff Garzik
> Sent: Thursday, November 10, 2005 8:34 PM
> To: Andrew Morton; Linus Torvalds
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Greg KH
> Subject: [PATCH] lpfc build fix
> 
> 
> Current upstream 'allmodconfig' build is broken.  This is the obvious
> patch...
> 
> Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c 
> b/drivers/scsi/lpfc/lpfc_init.c
> index c907238..0749811 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -1704,7 +1704,6 @@ MODULE_DEVICE_TABLE(pci, lpfc_id_table);
>  
>  static struct pci_driver lpfc_driver = {
>  	.name		= LPFC_DRIVER_NAME,
> -	.owner		= THIS_MODULE,
>  	.id_table	= lpfc_id_table,
>  	.probe		= lpfc_pci_probe_one,
>  	.remove		= __devexit_p(lpfc_pci_remove_one),
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
