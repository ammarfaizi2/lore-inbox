Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268497AbRHFNt1>; Mon, 6 Aug 2001 09:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbRHFNtR>; Mon, 6 Aug 2001 09:49:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42513 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268497AbRHFNtH>; Mon, 6 Aug 2001 09:49:07 -0400
Subject: Re: Problem in Interrupt Handling ....
To: vvgkrishna_78@yahoo.com (Venu Gopal Krishna Vemula)
Date: Mon, 6 Aug 2001 14:51:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Venu Gopal Krishna Vemula" at Aug 06, 2001 06:27:00 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Tkmf-00011f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> serial communication adapter which is based on
> interrrupt driven IO, top half handles registering the
> Immediate task queue and  acknowledging to PIC, bottom
> half performs the actual task of interrupt handling. 

Why are you touching the PIC at all - the kernel handles the PIC for you.
Indeed you IRQ might not even be coming from a PIC
