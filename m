Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbRFVBVW>; Thu, 21 Jun 2001 21:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265214AbRFVBVL>; Thu, 21 Jun 2001 21:21:11 -0400
Received: from ut-ras1-dial47.uniweb.net.co ([200.24.96.47]:48913 "EHLO
	earth.cj.osso.org.co") by vger.kernel.org with ESMTP
	id <S265074AbRFVBVG> convert rfc822-to-8bit; Thu, 21 Jun 2001 21:21:06 -0400
Date: Thu, 21 Jun 2001 20:20:43 -0500 (COT)
From: "Jhon H. Caicedo" <jhcaiced@osso.org.co>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "Jhon H. Caicedo" <jhcaiced@osso.org.co>, <linux-kernel@vger.kernel.org>
Subject: Re: AMD756VIPER PCI IRQ Routing Patch (Need Additional Tests)
In-Reply-To: <3B32818B.CECD9505@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106212012250.30398-100000@earth.cj.osso.org.co>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Thanks for your comment,

I haven't used read_config_nybble, write_config_nybble in order to use the
same code with this kernel patch (2.4.X) and a patch for pcmcia-cs
(pci_fixup.c) to use with linux 2.2.X

I think it would be better to rewrite the patch using the nybble functions
and "import" the nybble functions to the pcmcia-cs code, I will work on
it tomorrow and send it to the kernel mailing list.

Again, Thanks for the comment and for take the time to review the code.

Best wishes,

On Thu, 21 Jun 2001, Jeff Garzik wrote:

> Can you use read_config_nybble and write_config_nybble, in your patch?
>

-- 
--
Jhon H. Caicedo O. <jhcaiced@osso.org.co>
Observatorio Sismológico del SurOccidente O.S.S.O
http://www.osso.org.co
Cali - Colombia

