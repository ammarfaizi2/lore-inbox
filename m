Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316245AbSEQOh5>; Fri, 17 May 2002 10:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316248AbSEQOhQ>; Fri, 17 May 2002 10:37:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316247AbSEQOgZ>; Fri, 17 May 2002 10:36:25 -0400
Subject: Re: Dell Inspiron i8100 with 2 batteries
To: rutt@chezrutt.com
Date: Fri, 17 May 2002 15:56:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15589.4802.37068.931146@localhost.localdomain> from "John Ruttenberg" at May 17, 2002 10:25:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178j9U-0006fz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of the batteries is less than 50% (according to the bios), then /proc/apm
> shows the battery power level X 2.  If the combined charge of the batteries is
> greater than 50%, then /proc/apm shows:
> 
>     1.16 1.2 0x03 0x01 0xff 0x10 -1% -1 ?
> 
> I think this is because the bogus calculation it would make would result in a
> percentage > 100.
> 
> I took a quick look at arch/i386/kernel/apm.c but it wasn't obvious what to
> do.

The data basically comes from the BIOS as is
