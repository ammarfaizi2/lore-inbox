Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310484AbSCGTdW>; Thu, 7 Mar 2002 14:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310480AbSCGTdD>; Thu, 7 Mar 2002 14:33:03 -0500
Received: from pat.uio.no ([129.240.130.16]:33250 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S310478AbSCGTcq>;
	Thu, 7 Mar 2002 14:32:46 -0500
To: Alexander.Riesen@synopsys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-SMP: problem locking nfs files mounted on HPUX (ENOLCK)
In-Reply-To: <20020307180608.A2750@riesen-pc.gr05.synopsys.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Mar 2002 20:32:39 +0100
In-Reply-To: <20020307180608.A2750@riesen-pc.gr05.synopsys.com>
Message-ID: <shslmd4jhrc.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alex Riesen <Alexander.Riesen@synopsys.com> writes:

     > Hi, all i'm trying to lock a file using advisory locks.  The
     > file is on the filesystem exported by a linux machine (RH 6.2,
     > 2.4.2-SMP). The filesystem is mounted on HP-UX B.11.00 (HP-UX
     > host1 B.11.00 A 9000/785 2011306912 two-user license).  Right
     > now i cannot try this with the newer kernels.

     > The following simple program fails with ENOLCK.

HP clients require the 'insecure_locks' option to be set in the RedHat
server's /etc/exports file.

Cheers,
   Trond
