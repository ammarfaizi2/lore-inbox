Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316627AbSERChi>; Fri, 17 May 2002 22:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316631AbSERChh>; Fri, 17 May 2002 22:37:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316627AbSERChg>; Fri, 17 May 2002 22:37:36 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 18 May 2002 03:57:33 +0100 (BST)
Cc: zaitcev@redhat.com (Pete Zaitcev), linux-kernel@vger.kernel.org
In-Reply-To: <E178sfK-0006dG-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 18, 2002 11:05:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178uPV-0007iX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > and foolish to program without reading interface specifications
> > or the code. It did not occur to me to shift the blame onto
> > copy_from_user creators.
> 
> Please send me your mailing address.  I shall send you a copy of
> "Design of Everyday Things" (Donald A Norman).  You should not blame
> yourself for others' bad design.

By extrapolation perhaps you'd also care to reimplement it in terms of
exceptions, refcount the objects with an object based primitive to do the
transfers, garbage collect to remove memory leaks and implement strings and
variable size buffers as base objects.

Thats where your argument goes
