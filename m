Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276534AbRI2Psw>; Sat, 29 Sep 2001 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRI2Psm>; Sat, 29 Sep 2001 11:48:42 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:785 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S276534AbRI2Pse>; Sat, 29 Sep 2001 11:48:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 OPPS on 'Freeing initrd memory:'
Date: Sat, 29 Sep 2001 11:48:53 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15nMKf-0001ut-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using Initrd Dynamic on 2.4.10 the kernel will opps a NULL pointer 
deference after the code calls 
	infile.f_op->release(inode, &infile);

Any ideas why? rd.c has changed quite a bit since 2.4.9, but I don't see what 
could be causeing this.

The current Initrd Dynamic patch works fine up to 2.4.9 as well as recent 2.0 
and 2.2 kernels. Who broke rd.c this time around?

Dave

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
