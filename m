Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273477AbRIUMOz>; Fri, 21 Sep 2001 08:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273474AbRIUMOr>; Fri, 21 Sep 2001 08:14:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10259 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273479AbRIUMOf>; Fri, 21 Sep 2001 08:14:35 -0400
Subject: Re: Intel 82815 VGA
To: rmo@eurotux.com (Ricardo Manuel Oliveira)
Date: Fri, 21 Sep 2001 13:19:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BAB140E.3E42DF27@eurotux.com> from "Ricardo Manuel Oliveira" at Sep 21, 2001 10:18:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kPHi-0008Ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Problem with i815EM chipset (in ASUS M1000 laptop series) -
> the display blinks *VERY* frequently - seems to blink for
> every disk access or so.

It shouldnt be affected by PCI traffic but I guess its possible someone
has been sawing bits off. Try turning off ide DMA 

(hdparm -d0 /dev/hda)

Alan
