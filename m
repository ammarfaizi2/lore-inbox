Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311844AbSCNWqG>; Thu, 14 Mar 2002 17:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311847AbSCNWpr>; Thu, 14 Mar 2002 17:45:47 -0500
Received: from mars.wil.waw.pl ([148.81.118.4]:23682 "EHLO mars.wil.waw.pl")
	by vger.kernel.org with ESMTP id <S311844AbSCNWpd>;
	Thu, 14 Mar 2002 17:45:33 -0500
Message-ID: <001501c1cba9$efce22a0$0c765194@wil.waw.pl>
From: "Marek Malowidzki" <malowidz@wil.waw.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Default kernel configuration
Date: Thu, 14 Mar 2002 23:45:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I hope that this question is not too simple for this list. After many attempts I
finally gave up and ask for some help.

I would like to recompile the kernel (after some code modification - no hacking,
just a research project). So the first step would be to try to recompile the
kernel in the default (that is, installed) configuration. But where is it (the
config file)? /usr/src/linux-2.4/.config is far from the installed
configuration. Should it be
/usr/src/linux-2.4.7-10/configs/kernel-2.4.7-10-i686.config? When I copy this
file to /usr/src/linux-2.4/.config and perform make dep, make clean and make
bzImage, I get errors in apic.c (e.g. 389: nmi_watchdog undefined, and some more
undefined symbols).

So my question is: where is the config file with the default (installation)
configuration?

RedHat 7.2, kernel 2.4.7-10, Pentium II machine.

Best regards,

Marek


