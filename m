Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281819AbRKQU16>; Sat, 17 Nov 2001 15:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281820AbRKQU1t>; Sat, 17 Nov 2001 15:27:49 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:10662 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281819AbRKQU1a>; Sat, 17 Nov 2001 15:27:30 -0500
Message-ID: <002501c16fa6$3fff8850$fe78a8c0@tp2khel>
From: Frank.Heldt@t-online.de (Frank Heldt)
To: <Carmelo_Amoroso@tivoli.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <OFCE280D85.54A2C557-ON86256B06.00377BF1@rome.tivoli.com>
Subject: Re: Token Ring PCMCIA does not work
Date: Sat, 17 Nov 2001 21:27:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Carmelo,

i have seen this behavior on my Thinkpad T20, too. The problem disapears
when you give an
explicit interupt for the ibmtr_cs module. Just put something like this in
e.g. /etc/pcmcia/ibm.conf

# my card has irq 10
module "ibmtr_cs" opts "irq_list=10"

Bye
    Frank


