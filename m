Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbSLGJrI>; Sat, 7 Dec 2002 04:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbSLGJrI>; Sat, 7 Dec 2002 04:47:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267736AbSLGJrH>;
	Sat, 7 Dec 2002 04:47:07 -0500
Message-ID: <3DF1C53D.8030506@pobox.com>
Date: Sat, 07 Dec 2002 04:54:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathaniel Russell <root@chartermi.net>
CC: reddog83@chartermi.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.20] Via 8233 Sound Support
References: <Pine.LNX.4.44.0212070433220.6330-200000@reddog.example.net>
In-Reply-To: <Pine.LNX.4.44.0212070433220.6330-200000@reddog.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathaniel Russell wrote:
> diff -urN linux-sound/drivers/sound/via82cxxx_audio.c linux/drivers/sound/via82cxxx_audio.c
> --- linux-sound/drivers/sound/via82cxxx_audio.c	2002-08-02 20:39:44.000000000 -0400
> +++ linux/drivers/sound/via82cxxx_audio.c	2002-12-07 04:28:04.000000000 -0500
> @@ -354,6 +353,8 @@
>  static struct pci_device_id via_pci_tbl[] __initdata = {
>  	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
>  	  PCI_ANY_ID, PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,
> +	  PCI_ANY_ID, PCI_ANY_ID, },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci,via_pci_tbl);


unfortunately this only works sporadically, and only for some motherboards.

There is a reason why I removed this pci id from the driver, after 
foolishly adding it :)

