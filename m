Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310331AbSCGNpr>; Thu, 7 Mar 2002 08:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310330AbSCGNph>; Thu, 7 Mar 2002 08:45:37 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:62241 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S310328AbSCGNpV>; Thu, 7 Mar 2002 08:45:21 -0500
From: "Steven A. DuChene" <linux-clusters@mindspring.com>
Date: Thu, 7 Mar 2002 08:45:14 -0500
To: linux-kernel@vger.kernel.org
Subject: SCHED_YIELD undeclared with Trond's NFS patch w/2.4.19-pre2-ac2
Message-ID: <20020307084514.C16224@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to apply Trond's linux-2.4.18-NFS_ALL.dif patch to 2.4.19-pre2-ac2
I get the patch to apply once I massage fs/nfs/inode.c a little bit but when I try
to compile it I get:

svcsock.c: In function `svc_recv':
svcsock.c:987: `SCHED_YIELD' undeclared (first use in this function)
svcsock.c:987: (Each undeclared identifier is reported only once
svcsock.c:987: for each function it appears in.)
make[3]: *** [svcsock.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.X/net/sunrpc'
make[2]: *** [first_rule] Error 2

Now I know there were some changes because of the O(1) stuff in the ac2 patch but
what is the process for eliminating references to SCHED_YIELD?
-- 
Steven A. DuChene      linux-clusters@mindspring.com
                      sduchene@mindspring.com

        http://www.mindspring.com/~sduchene/
