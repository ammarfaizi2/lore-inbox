Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSIJRpO>; Tue, 10 Sep 2002 13:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSIJRpN>; Tue, 10 Sep 2002 13:45:13 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:62656 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S316610AbSIJRpN>; Tue, 10 Sep 2002 13:45:13 -0400
Message-Id: <200209101801.g8AI12J3001319@pool-141-150-242-242.delv.east.verizon.net>
Date: Tue, 10 Sep 2002 14:01:00 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL] Comment fix asm-i386_hardirq.h
References: <20020910092648.628692C361@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910092648.628692C361@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Sep 10, 2002 at 07:26:13PM +1000
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop017.verizon.net from [141.150.242.242] using ID <vze2j9fk@verizon.net> at Tue, 10 Sep 2002 12:49:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Trivial Russell wrote:
> [ The best bit about this is how every arch copied the comment 8) ]
 [ cc'ing trivial ]

After those patches were generated, another arch copied the
incorrect comment.

--- linux/include/asm-sparc/hardirq.h~	Tue Sep 10 13:56:32 2002
+++ linux/include/asm-sparc/hardirq.h	Tue Sep 10 13:56:47 2002
@@ -39,8 +39,8 @@
  * - ( bit 26 is the PREEMPT_ACTIVE flag. )
  *
  * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
+ * SOFTIRQ_MASK: 0x0000ff00
+ * HARDIRQ_MASK: 0x00ff0000
  */
 
 #define PREEMPT_BITS    8

-- 
Skip
