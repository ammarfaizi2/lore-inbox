Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSEMBKD>; Sun, 12 May 2002 21:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEMBKC>; Sun, 12 May 2002 21:10:02 -0400
Received: from loisexc2.loislaw.com ([12.5.234.240]:13068 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S315459AbSEMBKA>; Sun, 12 May 2002 21:10:00 -0400
Message-ID: <4188788C3E1BD411AA60009027E92DFD0962E252@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Segfault hidden in list.h
Date: Sun, 12 May 2002 20:10:03 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I stand corrected. I guess my philosophy is for the long sought after
"prefect world" example...

Cheers :)

Billy Rose 
wrose@loislaw.com

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> Sent: Sunday, May 12, 2002 7:59 PM
> To: Rose, Billy
> Cc: Kernel Mailing List
> Subject: Re: Segfault hidden in list.h
> 
> 
> 
> 
> On Sun, 12 May 2002, Rose, Billy wrote:
> >
> > If something is accessing the list in reverse at the time 
> of insertion and
> > "next->prev = new;" has been executed, there exists a 
> moment when new->prev
> 
> No.
> 
> If the coder doesn't lock his data structures, it doesn't 
> matter _what_
> order we execute the list modifications in - different 
> architectures will
> do different thing with inter-CPU memory ordering, and trying to order
> memory accesses on a source level is futile.
> 
> 		Linus
> 
