Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbREPX0C>; Wed, 16 May 2001 19:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262134AbREPXZw>; Wed, 16 May 2001 19:25:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12045 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262133AbREPXZo>; Wed, 16 May 2001 19:25:44 -0400
Subject: Re: IRQ usage for PCI devices, Kernel 2.4.4
To: backes@rhrk.uni-kl.de
Date: Thu, 17 May 2001 00:22:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LINUX Kernel)
In-Reply-To: <XFMail.20010516074607.backes@rhrk.uni-kl.de> from "Joachim Backes" at May 16, 2001 07:46:07 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150Acl-0004az-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         May 13 14:24:41 sunny kernel: PCI: Found IRQ 10 for device 00:0e.0
>         May 13 14:24:41 sunny kernel: PCI: The same IRQ used for device 00:0a.0
> "0e" is my PCI sound card, and "0a" is my PCI ethernet card. The messages apppear in
> the following environment: I send from another linux machine (per ssh) a command
> wich plays some sound on my sound card, therefore the eth0 event and the sound
> event occur at almost the same time.
> 
> Question: Can I ignore these messages, or is there any buggy behaviour?

This is debugging messages - you can ignore them. PCI supports IRQ sharing
