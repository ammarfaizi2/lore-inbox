Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314450AbSEHPNI>; Wed, 8 May 2002 11:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314453AbSEHPNH>; Wed, 8 May 2002 11:13:07 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:52717 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314450AbSEHPNG>; Wed, 8 May 2002 11:13:06 -0400
Date: Wed, 08 May 2002 08:12:12 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>, Gerrit Huizenga <gh@us.ibm.com>
cc: Clifford White <ctwhite@us.ibm.com>, linux-kernel@vger.kernel.org,
        oliendm@us.ibm.com
Subject: Re: x86 question: Can a process have > 3GB memory? 
Message-ID: <191939915.1020845530@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44L.0205072155220.32261-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hey Cliff, we are planning to implement virtwin() if you remember that
>> from PTX.  AWE on NT was derived from the same work.  There should soon
>> be some discussion about it on lse-tech@lists.sourceforge.net or I can
>> give you some more data...
> 
> Please implement it in userspace, using large POSIX shared memory
> segments and mmaping / munmapping them as needed.
> 
> This seems like a special enough case to keep it out of the kernel
> entirely. If there's something not efficient enough we could work
> on optimising the whole mmap & munmap path...

How are you going to change the user page tables from userspace?
This mechanism would seem to need kernel support however you did it.

M.

