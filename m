Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270188AbRHMNN4>; Mon, 13 Aug 2001 09:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270186AbRHMNNq>; Mon, 13 Aug 2001 09:13:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270189AbRHMNNa>; Mon, 13 Aug 2001 09:13:30 -0400
Subject: Re: Oops on 2.4.7-ac7 / ac11 in ide-scsi
To: francois.lorrain@attglobal.net (Francois Lorrain)
Date: Mon, 13 Aug 2001 14:16:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B774DA9.5050500@attglobal.net> from "Francois Lorrain" at Aug 12, 2001 08:46:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WHZd-0007Oe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I can trigger this oops from a user program running from a non 
> priviledged account : dos -A (dosemu). It kills the kernel in an 
> interrupt routine so I have to transcribe the oops from the dump 
> on-screen :-)

Does this still happen on 2.4.8ac2. I backed out a change in the scsi
code that seemed to make things very unhappy for several ide-scsi users.

