Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265299AbRF0IHb>; Wed, 27 Jun 2001 04:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265298AbRF0IHV>; Wed, 27 Jun 2001 04:07:21 -0400
Received: from mail.fbab.net ([212.75.83.8]:24078 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S265295AbRF0IHF>;
	Wed, 27 Jun 2001 04:07:05 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.631607 secs)
Message-ID: <002b01c0fee0$6429bc00$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Maximum mountpoints + chrooted login
Date: Wed, 27 Jun 2001 10:08:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking of doing a chrooted login for some ssh accounts.
The plan is this:

put stuff in
/home/u_dev
/home/u_etc
/home/u_bin

Then at login time mount them to
/home/user/dev
/home/user/etc
/home/user/bin
as readonly

chroot to /home/user

...

And then unmount them at logout time.

Does this seem like a bad idea?
(then please tell me why :))

One problem could be the _massive_ mounts, 3*online_users.
Are there any limits/drawbacks doing it like this?
Should i hardlink stuff instead? (worse maintainability).

Just a funny idea i have...
Hit me.

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


