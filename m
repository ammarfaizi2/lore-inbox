Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135601AbREFATv>; Sat, 5 May 2001 20:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135608AbREFATl>; Sat, 5 May 2001 20:19:41 -0400
Received: from vill.ha.smisk.nu ([212.75.83.8]:58372 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S135601AbREFATh>;
	Sat, 5 May 2001 20:19:37 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: marko@l-t.ee linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 7.654526 secs)
Message-ID: <018701c0d5c2$67a2ad20$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Marko Kreen" <marko@l-t.ee>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef> <20010505223034.C9629@l-t.ee>
Subject: Re: 2.4.4 fork() problems (maybe)
Date: Sun, 6 May 2001 02:20:50 +0200
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
> On Sat, May 05, 2001 at 09:07:53PM +0200, Magnus Naeslund(f) wrote:
> > Hello, I saw that there was something changed on how fork() works, and
> > wonder if this could be the cause my problem.
> > When i do a "su - <user>" it just hangs.
> > When i run strace on it i see that it forks and wait()s on the child.
> > 
> > Sometimes when i strace the su command it succeeds to give me a shell,
> > sometimes not.
> > But it allways fails when i don't strace it.
> 
> 2.4.4 has some problems with fork() but your problem seems to be
> something else.  Are you using RedHat 7.1?  (Or whatever it was
> the latest...)  The su-acting-weird problem has been reported 
> before and was traced to some PAM problems.  Try to download
> some upgrades from RedHat, maybe it will help.
> 
> -- 
> marko
> 

No i use redhat 6.2 (on a alpha system).
It works fine with 2.4.3, which i am running now ( i backed out 2.4.4 ).

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-




