Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbREETHB>; Sat, 5 May 2001 15:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135258AbREETGw>; Sat, 5 May 2001 15:06:52 -0400
Received: from vill.ha.smisk.nu ([212.75.83.8]:37645 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S135256AbREETGl>;
	Sat, 5 May 2001 15:06:41 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.029956 secs)
Message-ID: <00fb01c0d596$afb30690$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.4 fork() problems (maybe)
Date: Sat, 5 May 2001 21:07:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I saw that there was something changed on how fork() works, and
wonder if this could be the cause my problem.
When i do a "su - <user>" it just hangs.
When i run strace on it i see that it forks and wait()s on the child.

Sometimes when i strace the su command it succeeds to give me a shell,
sometimes not.
But it allways fails when i don't strace it.

Magnus Naeslund


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


