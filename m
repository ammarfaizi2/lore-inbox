Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280752AbRKYHyO>; Sun, 25 Nov 2001 02:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280754AbRKYHyF>; Sun, 25 Nov 2001 02:54:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:54543 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280752AbRKYHxw>;
	Sun, 25 Nov 2001 02:53:52 -0500
Date: Sun, 25 Nov 2001 05:53:40 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: James Davies <james_m_davies@yahoo.com>, Wayne.Brown@altec.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.0
Message-ID: <20011125055339.E970@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anuradha Ratnaweera <anuradha@gnu.org>,
	James Davies <james_m_davies@yahoo.com>, Wayne.Brown@altec.com,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <86256B0F.0026CFDE.00@smtpnotes.altec.com> <20011125071857Z280740-17408+19611@vger.kernel.org> <20011125133157.A2190@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011125133157.A2190@bee.lk>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 25, 2001 at 01:31:57PM +0600, Anuradha Ratnaweera escreveu:
> On Sun, Nov 25, 2001 at 05:14:53PM +1000, James Davies wrote:
> > On Sun, 25 Nov 2001 16:52, Wayne.Brown@altec.com wrote:
> > > Is there going to be an "official" patch from 2.4.15 to 2.5.0?  I'd rather
> > > not ftp the whole kernel tarball over a modem connection, and I don't have
> > > the disk space on my laptop to keep both the complete 2.4 and 2.5 source at
> > > the same time anyway.
> > 
> > 2.4.15 is the same as 2.5.0
> 
> I think he is concerned about the _official_ 2.4.15 and the _official_ 2.5.0,
> because, subsequent patches for 2.5.0 will not _cleanly_ apply on 2.4.15 tree
> (although fixing them should be extremely trivial).
> 
> Can somebody confirm that the difference is only the version numbers in the
> Makefile, and no other changes in Documentation/ etc?

hey, the _oficial_ word from Linus is that it had changed only the version:

[acme@brinquedo b]$ diff -uNr 2.4.15 2.5.0
diff -uNr 2.4.15/Makefile 2.5.0/Makefile
--- 2.4.15/Makefile     Thu Nov 22 17:22:58 2001
+++ 2.5.0/Makefile      Fri Nov 23 04:23:44 2001
@@ -1,7 +1,7 @@
 VERSION = 2
-PATCHLEVEL = 4
-SUBLEVEL = 15
-EXTRAVERSION =-greased-turkey
+PATCHLEVEL = 5
+SUBLEVEL = 0
+EXTRAVERSION =

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

[acme@brinquedo b]$

See?

- Arnaldo
