Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbRGILtG>; Mon, 9 Jul 2001 07:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267037AbRGILs4>; Mon, 9 Jul 2001 07:48:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:1012 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267036AbRGILsx>; Mon, 9 Jul 2001 07:48:53 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.95.1010706094624.519A-100000@chaos.analogic.com> 
In-Reply-To: <Pine.LNX.3.95.1010706094624.519A-100000@chaos.analogic.com> 
To: root@chaos.analogic.com
Cc: "Gregory (Grisha) Trubetskoy" <grisha@ispol.com>,
        linux-kernel@vger.kernel.org
Subject: Re: reading/writing CMOS beyond 256 bytes? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Jul 2001 12:46:04 +0100
Message-ID: <19706.994679164@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



root@chaos.analogic.com said:
> Motherboard manufacturers who have rewritable BIOS chips now leave one
> page (typically 64k) for startup parameters. This is erased and
> written using the magic provided by the chip vendors.

You often have to do chipset-specific magic to enable the WE and Vpp lines
to BIOS flash chips. See drivers/mtd/maps/l440gx.c in my working tree for 
an example.

Don't try this at home, kids. :)

--
dwmw2


