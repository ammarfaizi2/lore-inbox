Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSDLKJw>; Fri, 12 Apr 2002 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313501AbSDLKJv>; Fri, 12 Apr 2002 06:09:51 -0400
Received: from nydalah028.sn.umu.se ([130.239.118.227]:55977 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S313491AbSDLKJu>; Fri, 12 Apr 2002 06:09:50 -0400
Message-ID: <003e01c1e1ff$56695be0$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Shing Chuang" <ShingChuang@via.com.tw>, <linux-kernel@vger.kernel.org>
In-Reply-To: <369B0912E1F5D511ACA5003048222B75A3C03E@exchtp02.via.com.tw>
Subject: Re: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic chip VT6105, V6105M.
Date: Fri, 12 Apr 2002 10:52:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="BIG5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Shing Chuang" <ShingChuang@via.com.tw>


> Hi,
>
>       This patch applied to linux kernel 2.4.19-per6 to support VIA's new
> NIC chip.
>       However, VIA don't have any nic chip with pci device id 0x6100 so
far,
> so this patch also remove the device ID 0x6100.
>
Typo here I guess... (it removes ID 0x3043)

<snip>
> @@ -345,7 +346,9 @@
>     CanHaveMII | ReqTxAlign },
>   { "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
>     CanHaveMII | HasWOL },
> - { "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
> + { "VIA VT6105 Rhine-III",    RHINE_IOTYPE, 256,
> +   CanHaveMII | ReqTxAlign },
> + { "VIA VT6105M Rhine-III",    RHINE_IOTYPE, 256,
>     CanHaveMII | ReqTxAlign }
>  };

Strange that Rhine-II doesn't require TxAlign, still the newer Rhine-III's
need it? Copy-paste typo or is it really this way?

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umea University, Sweden


