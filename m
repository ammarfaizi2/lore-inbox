Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbRGPLPd>; Mon, 16 Jul 2001 07:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbRGPLPY>; Mon, 16 Jul 2001 07:15:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267288AbRGPLPI>; Mon, 16 Jul 2001 07:15:08 -0400
Subject: Re: Linux 2.4.6-ac4
To: reality@delusion.de (Udo A. Steinberg)
Date: Mon, 16 Jul 2001 12:16:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3B524DCD.3C6D6187@delusion.de> from "Udo A. Steinberg" at Jul 16, 2001 04:13:33 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15M6ML-0005Ne-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +               /* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis
> +               /* Check for buggy part revisions */
> +               if (rev < 0x40 && rev > 0x42)
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Should be || - already fixed in my tree. The range comments are right
0x40-4f is 686B 0x40-0x42 are buggy

