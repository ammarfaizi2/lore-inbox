Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278177AbRJ1Le1>; Sun, 28 Oct 2001 06:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRJ1LeR>; Sun, 28 Oct 2001 06:34:17 -0500
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:40049 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278189AbRJ1LeF>; Sun, 28 Oct 2001 06:34:05 -0500
Message-ID: <3BDBED56.C66B17B7@mandrakesoft.com>
Date: Sun, 28 Oct 2001 06:34:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Riley Williams <rhw@MemAlpha.cx>
CC: H Peter Anvin <hpa@zytor.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2
In-Reply-To: <Pine.LNX.4.21.0110281044340.28398-200000@Consulate.UFP.CX>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:
> Note particularly the line...
> 
>      1  MODULE_LICENSE("GPL v2")
> 
> ...which indicates that drivers/net/pcmcia/xircom_tulip_cb.c is regarded
> as tainting the kernel - this string is NOT one of the ones that are
> accepted as untainted.

That's definitely a bug that needs fixing... "GPL v2" shouldn't taint.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

