Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135828AbREFUKc>; Sun, 6 May 2001 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135829AbREFUKV>; Sun, 6 May 2001 16:10:21 -0400
Received: from vill.ha.smisk.nu ([212.75.83.8]:20746 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S135828AbREFUKR>;
	Sun, 6 May 2001 16:10:17 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: marko@l-t.ee linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 7.909841 secs)
Message-ID: <000d01c0d668$bd8c3840$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Marko Kreen" <marko@l-t.ee>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef> <20010505223034.C9629@l-t.ee> <018701c0d5c2$67a2ad20$020a0a0a@totalmef> <20010506023917.A22722@l-t.ee>
Subject: Re: 2.4.4 fork() problems (maybe)
Date: Sun, 6 May 2001 22:11:30 +0200
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

From: "Marko Kreen" <marko@l-t.ee>
> On Sun, May 06, 2001 at 02:20:50AM +0200, Magnus Naeslund(f) wrote:
> > From: "Marko Kreen" <marko@l-t.ee>
> > > On Sat, May 05, 2001 at 09:07:53PM +0200, Magnus Naeslund(f) wrote:
> > > > When i do a "su - <user>" it just hangs.
> > > > When i run strace on it i see that it forks and wait()s on the
child.
>
> > No i use redhat 6.2 (on a alpha system).
> > It works fine with 2.4.3, which i am running now ( i backed out 2.4.4 ).
>
> Could you try 2.4.5-pre1?  If that too works then the problem
> quite possibly was indeed fork() child-first change.  If not,
> well, then it gets interesting...
>

I can confirm that 2.4.5pre1 does NOT have this problem at all.
Now everything works as it should.
I'll run this until next stable, and will report any trouble.

> --
> marko

Magnus Naeslund

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



