Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313639AbSDHOsH>; Mon, 8 Apr 2002 10:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313640AbSDHOsG>; Mon, 8 Apr 2002 10:48:06 -0400
Received: from [193.120.151.1] ([193.120.151.1]:60413 "EHLO mail.asitatech.com")
	by vger.kernel.org with ESMTP id <S313639AbSDHOsF>;
	Mon, 8 Apr 2002 10:48:05 -0400
From: "Jarlath Burke" <jarlath.burke@asitatech.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Jarlath Burke" <jarlath.burke@asitatech.com>
Subject: RARP server support on Linux 2.4
Date: Mon, 8 Apr 2002 15:50:51 +0100
Message-ID: <NCEGLAPNBLBCNHJEMJEKEEBGDCAA.jarlath.burke@asitatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm trying to get RARP to work on my 2.4.5 kernel, but I see that
RARP server support has been removed from it, and that it has
been moved to userland in the form of the rarpd daemon.

I have downloaded and compiled the rarpd daemon (and libpcap and
libnet dependencies), and got it to run on my 2.4.5 kernel, but I
don't know what to do with it.

With the 2.2.x kernel, if you ran the command "rarp -a", it would
give you a list of the current RARP cache, and it was possible to
manipulate the kernel's RARP table using the "rarp -s hostname hw_addr"
and "rarp -d hostname" commands.

But I can't see any way of doing this now - is there a utility to talk to
the rarpd daemon to view RARP entries and to manipulate the RARP
table? Is the RARP table still maintained in the kernel?

I'm not subscribed to the mailing list so please CC me on any replies.
Thanks in advance,
Jarlath.