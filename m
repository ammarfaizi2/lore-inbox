Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313924AbSEHNIF>; Wed, 8 May 2002 09:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313988AbSEHNIE>; Wed, 8 May 2002 09:08:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:33807 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313924AbSEHNID>; Wed, 8 May 2002 09:08:03 -0400
Date: Tue, 7 May 2002 21:56:28 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Clifford White <ctwhite@us.ibm.com>, <linux-kernel@vger.kernel.org>,
        <oliendm@us.ibm.com>
Subject: Re: x86 question: Can a process have > 3GB memory? 
In-Reply-To: <E175F87-0004pa-00@w-gerrit2>
Message-ID: <Pine.LNX.4.44L.0205072155220.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Gerrit Huizenga wrote:

> Hey Cliff, we are planning to implement virtwin() if you remember that
> from PTX.  AWE on NT was derived from the same work.  There should soon
> be some discussion about it on lse-tech@lists.sourceforge.net or I can
> give you some more data...

Please implement it in userspace, using large POSIX shared memory
segments and mmaping / munmapping them as needed.

This seems like a special enough case to keep it out of the kernel
entirely. If there's something not efficient enough we could work
on optimising the whole mmap & munmap path...

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

