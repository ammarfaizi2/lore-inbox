Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRIHQTU>; Sat, 8 Sep 2001 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270132AbRIHQTK>; Sat, 8 Sep 2001 12:19:10 -0400
Received: from [145.254.147.195] ([145.254.147.195]:3846 "EHLO
	picklock.adams.family") by vger.kernel.org with ESMTP
	id <S270073AbRIHQS5> convert rfc822-to-8bit; Sat, 8 Sep 2001 12:18:57 -0400
Message-ID: <3B9A45A4.D1B7EA69@loewe-komp.de>
Date: Sat, 08 Sep 2001 18:21:56 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.9-ac5 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ole =?iso-8859-1?Q?Andr=E9?= Vadla =?iso-8859-1?Q?Ravn=E5s?= 
	<zole@jblinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-pre5 missing pci id
In-Reply-To: <999953131.30644.1.camel@zole.jblinux.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ole André Vadla Ravnås wrote:
> 
> Hi again..
> 
> This patch adds a missing pci id required by the trident sound driver.
> 
> Best regards,
> Ole André
> 
> ---
> 
> --- linux/include/linux/pci_ids.h-orig  Sat Sep  8 11:41:13 2001
> +++ linux/include/linux/pci_ids.h       Sat Sep  8 11:41:34 2001
> @@ -852,6 +852,7 @@
>  #define PCI_DEVICE_ID_INTERG_2000      0x2000
>  #define PCI_DEVICE_ID_INTERG_2010      0x2010
>  #define PCI_DEVICE_ID_INTERG_5000      0x5000
> +#define PCI_DEVICE_ID_INTERG_5050      0x5050
> 
>  #define PCI_VENDOR_ID_REALTEK          0x10ec
>  #define PCI_DEVICE_ID_REALTEK_8029     0x8029
> 

The cyberpro5050 support is still only in the ac-tree.
Seeing your other patches: do you mix ac and linus trees?
