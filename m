Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBILFM>; Fri, 9 Feb 2001 06:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBILFC>; Fri, 9 Feb 2001 06:05:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34577 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129396AbRBILEp>; Fri, 9 Feb 2001 06:04:45 -0500
Subject: Re: Panic in 2.2.2-pre2 SMP several panics
To: sgcarr@civeng.adelaide.edu.au
Date: Fri, 9 Feb 2001 11:04:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A840590.11464.D9B937@localhost> from "Stephen Carr" at Feb 09, 2001 02:58:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RBMA-0006Sd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Panics below for 2.4.2-pre2 kernel.
> 
> The error I have got is spkput:over: d0826d4b put:1514 dev:eth0 
> kernel BUG at skbuff.c:93 using the e100 driver

Replace the e100 driver with the standard eepro100 driver we ship with the
kernel. You might also want to try 2.4.1-ac9 once it appears with 2.4.2-pre2
merged into it and the aic7xxx update.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
