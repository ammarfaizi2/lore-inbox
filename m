Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRJJUne>; Wed, 10 Oct 2001 16:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRJJUnO>; Wed, 10 Oct 2001 16:43:14 -0400
Received: from domino1.resilience.com ([209.245.157.33]:4319 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S270619AbRJJUnM> convert rfc822-to-8bit; Wed, 10 Oct 2001 16:43:12 -0400
Mime-Version: 1.0
Message-Id: <p05100303b7ea63566fe5@[10.128.7.49]>
In-Reply-To: <7B1EED0C5D58D411B73200508BDE77B2C53CAB@EXCHANGEB>
In-Reply-To: <7B1EED0C5D58D411B73200508BDE77B2C53CAB@EXCHANGEB>
Date: Wed, 10 Oct 2001 13:43:43 -0700
To: Markus =?iso-8859-1?Q?D=F6hr?= <doehrm@aubi.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] for 2.4.11 to get the Compaq array driver compiled
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:05 PM +0200 10/10/01, Markus Döhr wrote:
>diff -udr linux/include/scsi/scsi.h
>linux-2.4.10-ac10enterprise64/include/scsi/scsi.h
>--- linux/include/scsi/scsi.h   Fri Apr 27 22:59:19 2001
>+++ linux-2.4.10-ac10enterprise64/include/scsi/scsi.h   Tue Oct  9 00:02:19
>2001
>@@ -214,6 +214,12 @@
>  /* Used to get the PCI location of a device */
>  #define SCSI_IOCTL_GET_PCI 0x5387
>
>+/* Used to get Fibre Channel WWN and port_id from device */
>+#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5387
>+
>+/* Used to invoke Target Defice Reset for Fibre Channel */
>+#define SCSI_IOCTL_FC_TDR 0x5388
>+

No doubt there's some subtle reason for using 0x5387 twice? (Just curious.)
-- 
/Jonathan Lundell.
