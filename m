Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314377AbSEIVZb>; Thu, 9 May 2002 17:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSEIVZa>; Thu, 9 May 2002 17:25:30 -0400
Received: from [194.252.160.219] ([194.252.160.219]:34454 "EHLO st0.invers.fi")
	by vger.kernel.org with ESMTP id <S314377AbSEIVZa>;
	Thu, 9 May 2002 17:25:30 -0400
Date: Fri, 10 May 2002 00:24:58 +0300 (EEST)
From: tchiwam <tchiwam@ees2.oulu.fi>
X-X-Sender: tchiwam@st0
To: linux-kernel@vger.kernel.org
cc: Rik van Riel <riel@conectiva.com.br>, Gerrit Huizenga <gh@us.ibm.com>,
        Clifford White <ctwhite@us.ibm.com>, <oliendm@us.ibm.com>
Subject: Re: x86 question: Can a process have > 3GB memory? 
In-Reply-To: <Pine.LNX.4.44L.0205072155220.32261-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0205100020140.31628-100000@st0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hey Cliff, we are planning to implement virtwin() if you remember that
> > from PTX.  AWE on NT was derived from the same work.  There should soon
> > be some discussion about it on lse-tech@lists.sourceforge.net or I can
> > give you some more data...
>
> Please implement it in userspace, using large POSIX shared memory
> segments and mmaping / munmapping them as needed.
>
> This seems like a special enough case to keep it out of the kernel
> entirely. If there's something not efficient enough we could work
> on optimising the whole mmap & munmap path...

How about other architectures ? like PowerPc.
Last calculation I did used 11GB of ram (no swap) on a big Number
Muncher... Would it be nice to use the same code for testing on 32
architectures with swap ?

Philippe

