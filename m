Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSEHMZF>; Wed, 8 May 2002 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSEHMZE>; Wed, 8 May 2002 08:25:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313690AbSEHMZD>; Wed, 8 May 2002 08:25:03 -0400
Subject: Re: Unable to handle kernel paging request problem at shutdown on 2.2.12
To: pavankvk@indiatimes.com
Date: Wed, 8 May 2002 13:23:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205080509.KAA29799@WS0005.indiatimes.com> from "pavankvk" at May 08, 2002 10:56:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175QUB-0001SG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> everything went fine during installation.the system is running fine to my knowledge.
> The problem is with complete shutdown.when i give init 0 command,everything succeeded and the system is halted.But instead of getting a powerdown message finally, i got a error as below :

The kernel asked the BIOS to do an APM poweroff and the BIOS crashed. There
are a few BIOSes that fail when the 32bit APM poweroff interface is called,
notably in the old K6/Cyrix socket7 world. Its not actually going to do
any harm.
