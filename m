Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286265AbRLTOlG>; Thu, 20 Dec 2001 09:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLTOk5>; Thu, 20 Dec 2001 09:40:57 -0500
Received: from elin.scali.no ([62.70.89.10]:53778 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S286269AbRLTOkt>;
	Thu, 20 Dec 2001 09:40:49 -0500
Message-ID: <3C21F863.5278841A@scali.no>
Date: Thu, 20 Dec 2001 15:40:35 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: lkml <linux-kernel@vger.kernel.org>, nfs list <nfs@lists.sourceforge.net>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <3C21B30D.871B6BE4@scali.no> <15393.51009.856041.463215@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Steffen Persvold <sp@scali.no> writes:
> 
>     >> I've been getting random NFS EIO errors for a few months but
>     >> now it's repeatable. Trying to copy a large file from one 2.4.8
>     >> SMP box to another is consistently failing (at different
>     >> offsets >each time).
> 
> Please try the patch on
> 
>   http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-fattr.dif
> 
> that fixes at least 1 such EIO error which was discovered using fsx.
> 

I can do that, but since one of the clients reporting this problem is an Alpha machine running
2.2.19 the patch won't do much good (not that the patch is architecture dependent, but it's only for
2.4.17). Has this patch been there since 2.2 or is it a new "feature" in the "stable" #:) 2.4
kernels.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
