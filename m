Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284309AbRLGSoj>; Fri, 7 Dec 2001 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284324AbRLGSoa>; Fri, 7 Dec 2001 13:44:30 -0500
Received: from [213.156.59.6] ([213.156.59.6]:54026 "HELO
	smail2.dmz1.icn.siemens.it") by vger.kernel.org with SMTP
	id <S284309AbRLGSoV>; Fri, 7 Dec 2001 13:44:21 -0500
X-WebMail-UserID: salinarl@ikuws01.icn.siemens.it
Date: Fri, 7 Dec 2001 19:44:49 +0100
From: salinarl <Lanfranco.Salinari@icn.siemens.it>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00003484
Subject: Question about sniffers and linux
Message-ID: <3BEC87A2@webmail>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to everyone,
I am new to kernel internals, and I would like to know how can a sniffer
read whole packets, I mean including the link layer header. In the receive
path, this happens, I think,  in the net_rx_action(), but in the transmit
path?
I know that there is a function called dev_queue_xmit_nit() for this, but
how can a driver add a link layer header to a packet before this function
gets called? The hard_start_xmit() of the driver is, in fact, called after
the dev_queue_xmit_nit(), (in the function dev_queue_xmit() ).
I think I'm missing something important about the subject, but I hope someone 
will answer me, anyway.
Thank you in advance,

Lanfranco

