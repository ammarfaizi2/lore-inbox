Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131893AbRCXXmV>; Sat, 24 Mar 2001 18:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRCXXmM>; Sat, 24 Mar 2001 18:42:12 -0500
Received: from balzac.cybercable.fr ([212.198.0.198]:61553 "HELO
	balzac.cybercable.fr") by vger.kernel.org with SMTP
	id <S131897AbRCXXmF>; Sat, 24 Mar 2001 18:42:05 -0500
Message-ID: <00d801c0b4bb$e7a04be0$0201a8c0@cybercable.fr>
From: "Benoit Garnier" <bunch@wanadoo.fr>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Date: Sun, 25 Mar 2001 00:41:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szabolcs Szakacsits wrote :

> But if you start
> to think you get the conclusion that process killing can't be avoided if
> you want the system keep running.

What's the point in keeping the OS running if the applications are silently
killed?

If your box is running for example a mail server, and it appears that
another process is juste eating the free memory, do you really want to kill
the mail server, just because it's the main process and consuming more
memory and CPU than others?

Well, fine, your OS is up, but your application is not here anymore.

I just think there's no general solution, users must have the chance to
choose processes not to be killed, or malloc() returning errors.

----
Benoît GARNIER


