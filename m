Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSASSwH>; Sat, 19 Jan 2002 13:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286935AbSASSv5>; Sat, 19 Jan 2002 13:51:57 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:49537 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S286934AbSASSvq>; Sat, 19 Jan 2002 13:51:46 -0500
Message-ID: <001301c1a11a$79884580$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <refuse7@poczta.fm>, "Hans Reiser" <reiser@namesys.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020119121610.DD9D02B5D9@pa160.grajewo.sdi.tpnet.pl> <3C49A1C9.7090602@namesys.com> <20020119172934.4240F2B5D9@pa160.grajewo.sdi.tpnet.pl>
Subject: Re: reiserFS undeletion
Date: Sat, 19 Jan 2002 19:52:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Gniazdowski" <refuse7@poczta.fm>
To: "Hans Reiser" <reiser@namesys.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 19, 2002 6:29 PM
Subject: Re: reiserFS undeletion


> Dnia sob 19. styczeñ 2002 17:41, Hans Reiser wrote:
>
> > we only log metadata.
>
> I know. Butt if i delete some file, it dosnt mean i set zero on sectors on
> disk. So imvho all is needet is meta data.

Yes, but (not butt =) if you have done some other file operations after the
delete, your deleted file might have been overwritten by another file.
Especially if you have little free space on your hard disk.

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umea University, Sweden

- ABIT BP6(RU) - 2xCeleron 400 - 128MB/PC100/C2 Acer
- Maxtor 10/5400/U33 HPT P/M - Seagate 6/5400/U33 HPT S/M
- 2xDE-530TX - 1xTulip - Linux 2.4.17+ide+preempt

