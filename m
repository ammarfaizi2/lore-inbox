Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313032AbSEHPRd>; Wed, 8 May 2002 11:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSEHPRc>; Wed, 8 May 2002 11:17:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:52489 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313032AbSEHPRc>; Wed, 8 May 2002 11:17:32 -0400
Date: Wed, 8 May 2002 12:17:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Gerrit Huizenga <gh@us.ibm.com>, Clifford White <ctwhite@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <oliendm@us.ibm.com>
Subject: Re: x86 question: Can a process have > 3GB memory? 
In-Reply-To: <191939915.1020845530@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44L.0205081216590.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Martin J. Bligh wrote:

> >> Hey Cliff, we are planning to implement virtwin() if you remember that
> >> from PTX.  AWE on NT was derived from the same work.  There should soon
> >> be some discussion about it on lse-tech@lists.sourceforge.net or I can
> >> give you some more data...
> >
> > Please implement it in userspace, using large POSIX shared memory
> > segments and mmaping / munmapping them as needed.
>
> How are you going to change the user page tables from userspace?
> This mechanism would seem to need kernel support however you did it.

mmap(2) and munmap(2)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

