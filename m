Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132824AbRC2TUE>; Thu, 29 Mar 2001 14:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbRC2TTy>; Thu, 29 Mar 2001 14:19:54 -0500
Received: from proxyd.rim.net ([206.51.26.194]:33684 "HELO mhs99ykf.rim.net")
	by vger.kernel.org with SMTP id <S132824AbRC2TTl>;
	Thu, 29 Mar 2001 14:19:41 -0500
Message-ID: <A9FD1B186B99D4119BCC00D0B75B4D8107F45925@xch01ykf.rim.net>
From: Aaron Lunansky <alunansky@rim.net>
To: linux-kernel@vger.kernel.org
Subject: Mount locks on bad ISO image?
Date: Thu, 29 Mar 2001 14:16:03 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried mounting a file as an ISO image (turns out it was corrupted) - after
running mount file.iso /cdrom -o loop
mount hung and did not respond.. I could not ^Z it into the background, or
kill, or kill -9 it...

I'm certain that I have ISO and loopback support compiled into my kernel.

Anyone know what might be going on?


Regards,
Aaron
