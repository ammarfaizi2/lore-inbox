Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSKUWmV>; Thu, 21 Nov 2002 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSKUWmV>; Thu, 21 Nov 2002 17:42:21 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:12013 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265154AbSKUWmS>; Thu, 21 Nov 2002 17:42:18 -0500
From: "Roland Schwarz" <webmaster@rolandschwarz.net>
To: <linux-kernel@vger.kernel.org>
Subject: Interrupts problem with 3com network cards on dual-cpu systems ?
Date: Thu, 21 Nov 2002 23:51:25 +0100
Message-ID: <NNEIJAEFFFIEBKPOMOJFAEKDDLAA.webmaster@rolandschwarz.net>
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

Hi kernel-hackers out there ! :-)


Maybe someone of you can help me with a problem I have here with three
computers and Linux. Okay, three computers, all of them are DualCPU systems.

1. P2-300 dual, 256 megs of ram

2. P2-400 dual, 512 megs ram

3. P3-800 dual . 1 GB ram .

All computers use 3com network cards ( 3C95x ) , number one has two, this is
my gateway//firewall computer. As Distribution I currently use Suse Linux
8.1, kernel version 2.4.19-64 GB. Firewall is iptables.

The problem I encounter is a errormessage from the Linuxkernel going like
this:

ethx : interrupt postet but not delivered
ethx : resetting tx-ring pointer ( several times repeated )

and again from start.The effect is that the network device won't run anymore
and you have to restart the system, and thats not very nice. This effect
only occured in dual-cpu-mode.

With SMP disabled the Systems runs fine. Nice network performance and pretty
good working.

This effect occurs on system 1&3. But not on number 2, and for now I don't
have any idea why ( beside I'm happy with it :-) ).

So I wanted to ask you if someone has a idea what this could be ? If you
need further information and/or system specifications, just mail to me (
alternate email : webmaster@rolandschwarz.net ) .


Thanks alot for your patience !

Greetings from Trier / DE

Roland


