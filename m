Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311269AbSDAKFl>; Mon, 1 Apr 2002 05:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311274AbSDAKFb>; Mon, 1 Apr 2002 05:05:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311269AbSDAKFY>; Mon, 1 Apr 2002 05:05:24 -0500
Subject: Re: [RFC][PATCH] Summary of KL133/KM133 problems w/2.4.18 (screen corruption/MWQ)
To: ozone@algorithm.com.au (Andre Pang)
Date: Mon, 1 Apr 2002 11:19:11 +0100 (BST)
Cc: srwalter@yahoo.com (Steven Walter),
        dschiavu@public.srce.hr (Danijel Schiavuzzi),
        BrehmTomB@aol.com (Tom Brehm), teastep@shorewall.net (Tom Eastep),
        xcp@whisper.jaggnet.org (Bill Hammock),
        bds@jhb.ucs.co.za (Berend De Schouwer),
        vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
        VANDROVE@vc.cvut.cz (Petr Vandrovec), linux-kernel@vger.kernel.org
In-Reply-To: <1017644966.218140.3006.nullmailer@bozar.algorithm.com.au> from "Andre Pang" at Apr 01, 2002 05:09:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ryu7-00083Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that this is exactly what the VIA patches for Windows do:
> the VIA 4in1 drivers normally clear bits 5, 6 and 7 of register
> 55, but they do not clear bit 5 if the motherboard is a K[LM]133.
> This occurs on Windows 98 and Windows XP, and indicates to me
> that what this patch does should be the correct behaviour.

Thanks for doing the research

> If all goes well, I'll submit it to Alan/Marcelo/Dave.

I'll throw it into the -ac tree anyway and get you some coverage testing
