Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280749AbRKYHXm>; Sun, 25 Nov 2001 02:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKYHXW>; Sun, 25 Nov 2001 02:23:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61710 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280749AbRKYHXM>;
	Sun, 25 Nov 2001 02:23:12 -0500
Date: Sun, 25 Nov 2001 05:23:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Wayne.Brown@altec.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.0
Message-ID: <20011125052304.C970@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Wayne.Brown@altec.com, Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <86256B0F.0026CFDE.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86256B0F.0026CFDE.00@smtpnotes.altec.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 25, 2001 at 12:52:07AM -0600, Wayne.Brown@altec.com escreveu:
> Is there going to be an "official" patch from 2.4.15 to 2.5.0?  I'd
> rather not ftp the whole kernel tarball over a modem connection, and I
> don't have the disk space on my laptop to keep both the complete 2.4 and
> 2.5 source at the same time anyway.

Here it is:

------------------------------------- 8< ----------------------------
--- linux/Makefile.orig	Sun Nov 25 05:21:13 2001
+++ linux/Makefile	Sun Nov 25 05:21:23 2001
@@ -1,7 +1,7 @@
 VERSION = 2
-PATCHLEVEL = 4
-SUBLEVEL = 15
-EXTRAVERSION =-greased-turkey
+PATCHLEVEL = 5
+SUBLEVEL = 0
+EXTRAVERSION =
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
------------------------------------- 8< ----------------------------

RTFM http://www.kernel.org/pub/linux/kernel/v2.5/README

- Arnaldo
