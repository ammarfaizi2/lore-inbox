Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285125AbRLFLUE>; Thu, 6 Dec 2001 06:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285126AbRLFLTy>; Thu, 6 Dec 2001 06:19:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48139 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285125AbRLFLTt>; Thu, 6 Dec 2001 06:19:49 -0500
Subject: Re: 
To: romain_giry@yahoo.fr (Romain Giry)
Date: Thu, 6 Dec 2001 11:28:50 +0000 (GMT)
Cc: dipak@monmouth.com (Dipak),
        linux-kernel@vger.kernel.org (Linux-Kernel mailing list)
In-Reply-To: <5.0.2.1.0.20011206113115.00a53c10@pop.mail.yahoo.fr> from "Romain Giry" at Dec 06, 2001 11:43:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Bwhu-0001Md-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One thing that may be difficult to implement is that i want to keep a TCP
> connection running when i change the physical device. That's why maybe the
> firewall solution may be better because when receiving packets i could fake
> that they all come from the same physical device and have therefore the same
> IP.

You set up multiple physical devices with the same IP and use the "route"
command. Thats worked with TCP/IP protocols since day 1
