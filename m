Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315980AbSEGXRG>; Tue, 7 May 2002 19:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSEGXRF>; Tue, 7 May 2002 19:17:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9416 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315980AbSEGXRC>;
	Tue, 7 May 2002 19:17:02 -0400
To: "Clifford White" <ctwhite@us.ibm.com>
cc: linux-kernel@vger.kernel.org, oliendm@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: x86 question: Can a process have > 3GB memory? 
In-Reply-To: Your message of Tue, 07 May 2002 16:03:09 PDT.
             <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18570.1020816986.1@us.ibm.com>
Date: Tue, 07 May 2002 17:16:26 -0700
Message-Id: <E175F87-0004pa-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Cliff, we are planning to implement virtwin() if you remember
that from PTX.  AWE on NT was derived from the same work.  There
should soon be some discussion about it on lse-tech@lists.sourceforge.net
or I can give you some more data...

Worked for Oracle, should be good for large scientific apps, might
work for other piggy server applications as well.

gerrit

In message <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com>, > : "Clif
ford White" writes:
> 
> We are working with a database that requires a large amount of memory
> allocated by a single process.
> This is on an Intel 32-bit platform.
> We'd like to go > 3GB of memory per process.
> Is this possible on a 32-bit machine? I have been reading the various
> 'highmem' discussions, but that's kernel page tables...
> Or is this a glibc issue, and not proper for a kernel-list question?
> Any pointers would be appreciated. The Intel ESMA (Extended Server Memory
> Arch) page states that it's possible, but.....how?
> 
> cliffw
> NUMA-Q
> Technical Guy
> 1-503-578-4306
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
