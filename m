Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291633AbSBNN1k>; Thu, 14 Feb 2002 08:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291637AbSBNN13>; Thu, 14 Feb 2002 08:27:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46354 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291633AbSBNN1Q>; Thu, 14 Feb 2002 08:27:16 -0500
Subject: Re: Linux 2.4.18-rc1
To: bunk@fs.tum.de (Adrian Bunk)
Date: Thu, 14 Feb 2002 13:40:40 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.NEB.4.44.0202141404210.25879-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Feb 14, 2002 02:14:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bM7s-0008TY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   tridentfb.c:524: #error "Floating point maths. This needs fixing before
>   the driver is safe"
> 
> which makes it pretty useless. Since this is a stable kernel series I want
> to suggest that if there's no fix for this before 2.4.18-final to remove
> the trident support from 2.4.18 and to re-add it in 2.4.19-pre1 (with
> the hope that it will be fixed before 2.4.19-final).

Or just comment out the Config.in line for it ?
