Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSKTCME>; Tue, 19 Nov 2002 21:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSKTCME>; Tue, 19 Nov 2002 21:12:04 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:50444 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265564AbSKTCMD>; Tue, 19 Nov 2002 21:12:03 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1959@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Miguel S Filipe <m3thos@netcabo.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Disk Performance Issues [AMD Viper plus IDE chipset problems.
	 (wrong udma "autodetection")]
Date: Tue, 19 Nov 2002 18:18:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have actually used the ASUS motherboard with the amd768 southbridge. It is
also the 760MPX solution. And after making changes to the
config_chipset_for_dma function, you can get it to work at udma 100 ...

Thanks
Manish

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Saturday, November 16, 2002 3:34 PM
To: Miguel S Filipe
Cc: Linux Kernel Mailing List
Subject: Re: Disk Performance Issues [AMD Viper plus IDE chipset
problems. (wrong udma "autodetection")]


On Sat, 2002-11-16 at 20:19, Miguel S Filipe wrote:
> Hello there,
> 
>   I'm sending this email about a problem with udma settings
> in a TigerMP motherboard, wich supports UDMA 100.
>   I've send it to my distribution mailing list, and several others, to no
> avail, so, has a last resort I send it now to the Linux ML.
>   I'm using pure vanilla linux-2.4.19, and I tried all possible configs
> settings that I though that could affect this problem.

If I remember rightly 2.4.19 doesnt have full support for the AMD
760MP/X although 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
