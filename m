Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290660AbSARKl7>; Fri, 18 Jan 2002 05:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290663AbSARKlu>; Fri, 18 Jan 2002 05:41:50 -0500
Received: from th09.opsion.fr ([195.219.20.19]:4102 "HELO th09.opsion.fr")
	by vger.kernel.org with SMTP id <S290660AbSARKlc>;
	Fri, 18 Jan 2002 05:41:32 -0500
Message-ID: <011601c1a00d$33a8bd00$6414dbc3@opsion.fr>
From: "marko milovanovic" <m.milo@ifrance.com>
To: <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3C47FA17.A0ACA25C@stud.uni-saarland.de>
Subject: Re: kernel 2.4.7 on a 7.2 redha
Date: Fri, 18 Jan 2002 11:45:10 +0100
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

----- Original Message -----
From: "Studierende der Universitaet des Saarlandes"
<masp0008@stud.uni-saarland.de>
To: "marko milovanovic" <m.milo@ifrance.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, January 18, 2002 11:33 AM
Subject: Re: kernel 2.4.7 on a 7.2 redha


> > hi everyone,
> > we're running a 2.4.7-10smp kernel on a hp lh3000 server with 1gb ram
scsi
> > disks and 2 pentium iii cpus
> >
>
> Normal memory or ECC memory? It seems that a bit flip corrupted a data
> structure.

2 * 521MB Sync 133Mhz cl3 ECC

> > we have one a day a kernel panic  with this message :
> > *********************************************
> > Unable to handle kernel NULL pointer dereference at virtual address
0000000d
> > [snip]
> > Oops:
> > eax: e6d9842c   ebx: daabf760   ecx: d763daa0   edx: 00000001
> > [snip]
> > Code;  c01f35ad <tcp_v4_get_port+14d/290>   <=====
> >    0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====
>
> %edx is 1, probably 0 would have been correct.

so what does it mean? what can i possibly do?

thanks anyway for your quick answer!

> --
> Manfred

 
______________________________________________________________________________
ifrance.com, l'email gratuit le plus complet de l'Internet !
vos emails depuis un navigateur, en POP3, sur Minitel, sur le WAP...
http://www.ifrance.com/_reloc/email.emailif


