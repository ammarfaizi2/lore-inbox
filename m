Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286385AbRLTV1G>; Thu, 20 Dec 2001 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbRLTV0z>; Thu, 20 Dec 2001 16:26:55 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:24109 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S286385AbRLTV0n> convert rfc822-to-8bit; Thu, 20 Dec 2001 16:26:43 -0500
Date: Thu, 20 Dec 2001 20:24:23 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andreas Haumer <andreas@xss.co.at>
cc: <linux-kernel@vger.kernel.org>, <monika@xss.co.at>
Subject: Re: Deadlock: Linux-2.2.18, sym53c8xx, Compaq ProLiant, HP Ultrium
In-Reply-To: <3C21B21A.DF8110F2@xss.co.at>
Message-ID: <20011220201435.U2113-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Dec 2001, Andreas Haumer wrote:

[...]

> > > The Ultrium hardware error is not reproducable at will. It
> > > just happens every now and then.
> > > Next thing I will try is to use a different SCSI controller
> > > (Adaptec 29160 or the like) to see if the hanging process
> > > occurs with a different SCSI driver, too.
> >
> > This is indeed something to try.
> > I am very interested in the result.
> >
> The controller change is scheduled on December 28th.
> We'll then see how it works in the next weeks/months.
> I'll keep you (and LKML) informend...

Thanks in advance.

In the meantime, you may give a try with the newer major version of the
driver. It is available in latests 2.4.x and 2.5.x kernels and tarballs
usable under not too old linux-2.2.x are ftp-available:

 ftp://ftp.tux.org/roudier/drivers/protables/sym-2.1.x/

sym-2.1.16-20011028.tar.gz should apply to linux-2.2.18.

This new major driver version uses EH threads for error recovery.

  Gérard.

