Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131632AbRCUQhz>; Wed, 21 Mar 2001 11:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRCUQhp>; Wed, 21 Mar 2001 11:37:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34320 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131632AbRCUQhd>; Wed, 21 Mar 2001 11:37:33 -0500
Subject: Re: make: *** [vmlinux] Error 1
To: khc@intrepid.pm.waw.pl (Krzysztof Halasa)
Date: Wed, 21 Mar 2001 16:33:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3hf0yn42w.fsf@intrepid.pm.waw.pl> from "Krzysztof Halasa" at Mar 12, 2001 09:07:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14flYX-0000tT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you are using pgcc, try getting a real less-buggy compiler, like egcs1.1.2
> > or gcc-2.95 (even 2.96 willl work).
> 
> ... not always. I've had problems with gcc "2.96" from RH-7.0
> - the compiler was generating obviously incorrect code in some cases
> (and it wasn't .c code fault but a compiler problem).

2.96-69 is needed
2.96-74 for DAC960 (packing assumptions changed in gcc cvs)

