Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263904AbRFDVpm>; Mon, 4 Jun 2001 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263907AbRFDVpd>; Mon, 4 Jun 2001 17:45:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20493 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263904AbRFDVpS>; Mon, 4 Jun 2001 17:45:18 -0400
Subject: Re: kernel oops when burning CDs
To: rudo@internet.sk (Rudo Thomas)
Date: Mon, 4 Jun 2001 22:43:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106042037.f54KbgU08004@smtp.kolej.mff.cuni.cz> from "Rudo Thomas" at Jun 04, 2001 10:46:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15728I-00060D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get an ooops and immediate kernel panic when I break (CTRL-C) cdrecord. I 
> can reproduce it anytime. I use 2.4.5-ac series. Obviously, Linus' 2.4.5 is 
> fine.
> I know, I know. I was supposed to make a serios oops report, BUT I wasn't 

Write down the EIP and the call trace then look them up in System.map. Also
include the hardware details. The -ac tree has a newer version of the scsi
generic code. It fixes some oopses but in your case it apparently added a new
failure case
