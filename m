Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRBKUbW>; Sun, 11 Feb 2001 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130239AbRBKUbM>; Sun, 11 Feb 2001 15:31:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16654 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130238AbRBKUbD>; Sun, 11 Feb 2001 15:31:03 -0500
Subject: Re: small patch for unsigned char breakage in rtl8129 driver
To: philb@gnu.org (Philip Blundell)
Date: Sun, 11 Feb 2001 20:31:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14S2rf-0003or-00@kings-cross.london.uk.eu.org> from "Philip Blundell" at Feb 11, 2001 08:12:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S39a-0004wd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	char phys[4];						/* MII device addresses. */
> +	signed char phys[4];				/* MII device addresses. */

8129 is deprecated for the current 8139too driver which is the only stable
driver for it. Does 8139too (from current -ac) work on ARM ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
