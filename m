Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSFZMbn>; Wed, 26 Jun 2002 08:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSFZMbm>; Wed, 26 Jun 2002 08:31:42 -0400
Received: from ns.suse.de ([213.95.15.193]:14098 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316530AbSFZMbl>;
	Wed, 26 Jun 2002 08:31:41 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24: auto_fs.h typo.
References: <200206251759.34690.schwidefsky@de.ibm.com>
	<afb4im$6nl$1@cesium.transmeta.com>
X-Yow: There's a little picture of ED MCMAHON doing BAD THINGS to JOAN
 RIVERS
 in a $200,000 MALIBU BEACH HOUSE!!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 26 Jun 2002 14:31:41 +0200
In-Reply-To: <afb4im$6nl$1@cesium.transmeta.com> ("H. Peter Anvin"'s message
 of "25 Jun 2002 18:15:02 -0700")
Message-ID: <je7kkm8bma.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

|> Followup to:  <200206251759.34690.schwidefsky@de.ibm.com>
|> By author:    Martin Schwidefsky <schwidefsky@de.ibm.com>
|> In newsgroup: linux.dev.kernel
|> >
|> > Hi Linus,
|> > my last patch for include/linux/auto_fs.h contained a typo that removed the
|> > trailing underscores from __x86_64__.
|> > 
|> > blue skies,
|> >   Martin.
|> > 
|> > diff -urN linux-2.5.24/include/linux/auto_fs.h linux-2.5.24-s390/include/linux/auto_fs.h
|> > --- linux-2.5.24/include/linux/auto_fs.h	Fri Jun 21 00:53:40 2002
|> > +++ linux-2.5.24-s390/include/linux/auto_fs.h	Fri Jun 21 14:46:59 2002
|> > @@ -45,7 +45,7 @@
|> >   * If so, 32-bit user-space code should be backwards compatible.
|> >   */
|> >  
|> > -#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
|> > +#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) \
|> >   || defined(__powerpc__) || defined(__s390__)
|> >  typedef unsigned int autofs_wqt_t;
|> >  #else
|> > 
|> 
|> Please change this to:
|> 
|> #ifndef __alpha__

What about __ia64__?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
