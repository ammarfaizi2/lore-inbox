Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310711AbSCHHTT>; Fri, 8 Mar 2002 02:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310712AbSCHHTL>; Fri, 8 Mar 2002 02:19:11 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:45512 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S310711AbSCHHSy>; Fri, 8 Mar 2002 02:18:54 -0500
Date: Fri, 8 Mar 2002 08:16:23 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml@goofy.gr05.synopsys.com
Subject: Re: 2.4.2-SMP: problem locking nfs files mounted on HPUX (ENOLCK)
Message-ID: <20020308081623.B2750@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
In-Reply-To: <20020307180608.A2750@riesen-pc.gr05.synopsys.com> <shslmd4jhrc.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shslmd4jhrc.fsf@charged.uio.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 08:32:39PM +0100, Trond Myklebust wrote:
> >>>>> " " == Alex Riesen <Alexander.Riesen@synopsys.com> writes:
> 
>      > Hi, all i'm trying to lock a file using advisory locks.  The
>      > file is on the filesystem exported by a linux machine (RH 6.2,
>      > 2.4.2-SMP). The filesystem is mounted on HP-UX B.11.00 (HP-UX
>      > host1 B.11.00 A 9000/785 2011306912 two-user license).  Right
>      > now i cannot try this with the newer kernels.
> 
>      > The following simple program fails with ENOLCK.
> 
> HP clients require the 'insecure_locks' option to be set in the RedHat
> server's /etc/exports file.
> 

Thank you, we are trying this.
-alex
