Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSA3Mf2>; Wed, 30 Jan 2002 07:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSA3MfS>; Wed, 30 Jan 2002 07:35:18 -0500
Received: from [195.66.192.167] ([195.66.192.167]:42769 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289139AbSA3MfB>; Wed, 30 Jan 2002 07:35:01 -0500
Message-Id: <200201301232.g0UCWmt10496@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: David Weinehall <tao@acc.umu.se>
Subject: Re: [PATCH] KERN_INFO for devfs
Date: Wed, 30 Jan 2002 14:32:47 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200201291649.g0TGnnD8001332@tigger.cs.uni-dortmund.de> <200201300903.g0U933t08579@Port.imtp.ilyichevsk.odessa.ua> <20020130120934.R1735@khan.acc.umu.se>
In-Reply-To: <20020130120934.R1735@khan.acc.umu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 January 2002 09:09, David Weinehall wrote:
> > > >      else printk ("Warning: unable to mount devfs, err: %d\n", err);
> > >
> > >                     ^^^^^
> > >                      Missed this one
> >
> > Hmm. KERN_WARNING can be added there, but it is the default level anyway.
>
> Yes, but that may change (in theory, at least.) Consistency is a virtue.

I'll do this cleanup if my KERN_INFO patches will be accepted, at least some 
of them. So far only Richard Gooch replied...
--
vda
