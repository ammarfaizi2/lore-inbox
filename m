Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSFGXS5>; Fri, 7 Jun 2002 19:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSFGXS5>; Fri, 7 Jun 2002 19:18:57 -0400
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:1042 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S317361AbSFGXS4>; Fri, 7 Jun 2002 19:18:56 -0400
From: "Stephane Charette" <stephanecharette@telus.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 07 Jun 2002 16:18:56 -0700
Reply-To: "Stephane Charette" <stephanecharette@telus.net>
X-Mailer: PMMail 2000 Standard (2.10.2010) For Windows 2000 (5.0.2195;2)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: kernel serial debugging question
Message-Id: <20020607231856Z317361-22020+731@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background:
-----------

In the past, I have had to use the kernel serial debugger with the
2.2.14 kernel.

The steps I followed (if my notes are correct) were:

- in "make menuconfig", within "<Kernel Hacking>", select "<Kernel
support for GDB>"
- pass the additional options "gdb gdbttyS=1 gdbbaud=115200" to loadlin
- wait for the message "Waiting for connection from remote gdb on
ttyS1"


My question:
------------

Has any of this changed with the 2.4.x kernel?  I'm currently playing
with 2.4.19-pre9.  Is there a "serial debugger" patch that has to be
applied first, or is this support normally built-in?

The reason I ask is because I don't see the option "Kernel support for
GDB", which leads me to think that maybe this functionality actually
came from a patch that was applied on top of 2.2.14.

While I'm at it:  is there a "better", or perhaps a "more popular"
method of debugging the kernel?

Thanks,

Stephane Charette

