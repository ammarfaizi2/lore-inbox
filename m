Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbQLUTIY>; Thu, 21 Dec 2000 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbQLUTIF>; Thu, 21 Dec 2000 14:08:05 -0500
Received: from ccs.covici.com ([209.249.181.196]:33032 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S131184AbQLUTHw>;
	Thu, 21 Dec 2000 14:07:52 -0500
Date: Thu, 21 Dec 2000 13:37:23 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: strange nfs behavior in 2.2.18 and 2.4.0-test12
Message-ID: <Pine.LNX.4.21.0012211324000.7606-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I am having strange nfs problems in both my 2.x and 2.4.0-test12
kernels.

What is happening is that when the machine boots up and exports the
directories for nfs, it complains that

ccs2:/ invalid argument .

The exports entry is

/ ccs2(rw,no_root_squash)

Now in Kernel 2.2.18, if I stop and restart the nfs daemons, all is
OK, the invalid argument goes away, but in 2.4.0 I cannot get this to
work at all and so I cannot mount nfs from a client on the ccs2 box.
I am using the utilities 0.2.1-4 from the Debian distribution if that
makes any difference.  I did an strace once on exportfs and it was
having trouble with the call to nfsservctl which returns invalid argument.


Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
