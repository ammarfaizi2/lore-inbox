Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129456AbRB1Jqo>; Wed, 28 Feb 2001 04:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRB1Jqe>; Wed, 28 Feb 2001 04:46:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129456AbRB1JqW>; Wed, 28 Feb 2001 04:46:22 -0500
Subject: Re: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
To: bmoyle@mvista.com (Brian Moyle)
Date: Wed, 28 Feb 2001 09:49:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, bmoyle@mvista.com
In-Reply-To: <200102280312.TAA13404@bia.mvista.com> from "Brian Moyle" at Feb 27, 2001 07:12:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Y3Eq-0005K9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel 2.4.2-ac6 hangs while booting an AMD Elan SC520 development board.
> 
> memory map that hangs (added debugging to setup.S to determine E820 map):
>    hand-copied physical RAM map:
>     bios-e820: 000000000009f400 @ 0000000000000000 (usable)
>     bios-e820: 0000000000000c00 @ 000000000009f400 (reserved)
>     bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
>     bios-e820: 0000000003f00000 @ 0000000000100000 (usable)

The same block listed twice. Thats probably the trigger. I'll take a look
see if there is an obvious cause


