Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSF0RdG>; Thu, 27 Jun 2002 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSF0RdF>; Thu, 27 Jun 2002 13:33:05 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:2193 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316895AbSF0RdF> convert rfc822-to-8bit; Thu, 27 Jun 2002 13:33:05 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-)
To: linux-kernel@vger.kernel.org
Subject: Re: another way to activate AMD disconnect on VIA KT266 (aka cooling bits)
Date: Thu, 27 Jun 2002 19:35:18 +0200
User-Agent: KMail/1.4.1
Cc: utx@penguin.cz
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206271935.18064.knobi@knobisoft.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hallo, 
>
>
>I have been experimenting with AMD disconnect with my VIA KT266 based 
>MSI K7T266Pro (MS-6380). 
>
>
>LVCool does not yet support KT266, method discussed in LKML in past 
>(http://cip.uni-trier.de/nofftz/linux/Athlon-Powersaving-HOWTO.html) 
>does not activate low power mode on my mainboard. The only bit set by 
>this patch is already set probably by BIOS of my motherboard and does 
>not help. So I have checked VCool (http://vcool.occludo.net/) & Wine & 
>lspci and found following bit changes: 
>
>
>enable: 
>setpci -v -H1 -s 0:0.0 70=86 
>setpci -v -H1 -s 0:0.0 95=1e 
>disable: 
>setpci -v -H1 -s 0:0.0 70=82 
>setpci -v -H1 -s 0:0.0 95=1c 
>
>
>The result is 15 degrees temperature decrease on low system load! 

 I can attest that this also works on a Biostar M7VIF-X (KT333). Idle 
temperature of the XP2100+ is down to 54-55 degC from 68-72 degC. And the box 
is a bit more silent.

Martin
-- 
----------------------------------
Martin Knoblauch
knobi@knobisoft.de
http://www.knobisoft.de
