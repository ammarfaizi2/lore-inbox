Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131187AbRBPUSn>; Fri, 16 Feb 2001 15:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131185AbRBPUSd>; Fri, 16 Feb 2001 15:18:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131167AbRBPUSS>; Fri, 16 Feb 2001 15:18:18 -0500
Subject: Re: (2.4.1-ac15) pcmcia irq conflict
To: junfan@penguinfarm.com (Jason Straight)
Date: Fri, 16 Feb 2001 20:18:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A8D6E23.77D1891D@penguinfarm.com> from "Jason Straight" at Feb 16, 2001 01:14:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TrL9-00043y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a Dell Inspiron 8000. Trying to use pcmcia with kernel
> (yenta_socket) or pcmcia-cs only causes pcmcia card to take irq 11,
> which my eth device is on also. This didn't happen with 2.2 or 2.4.0
> kernels.

Sharing a PCI irq is legal, so that isnt the cause. It could be that the
irq routing isnt getting handled correctly however. 
