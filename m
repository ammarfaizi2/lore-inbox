Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSJMIfK>; Sun, 13 Oct 2002 04:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbSJMIfK>; Sun, 13 Oct 2002 04:35:10 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:59938 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261418AbSJMIfJ>; Sun, 13 Oct 2002 04:35:09 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'David S. Miller'" <davem@redhat.com>
Cc: <robm@fastmail.fm>, <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>, <jhoward@fastmail.fm>
Subject: RE: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 03:40:51 -0500
Message-ID: <000f01c27294$438d5fa0$7443f4d1@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20021013.011344.58438240.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not true.  While a block is being allocated on mounted
> filesystem X on one cpu, a TCP packet can be being
> processed on another processor and a block can be allocated
> on mounted filesystem Y on another processor.

Does anyone besides me notice that the more Dave and I argue the longer
and longer the list of extenuating circumstances gets in order for Dave
to continue to be right?

In this email, I'm not right if the data is on separate partitions.

Dave, do you realize how many people, despite advice to the contrary,
put everything on one honk'in / partition?  For all those people, I'm
right.

Dave, you're confusing the rule with the exceptions to the rule.  I'm
right as a general rule, and you're pointing out all the exceptions to
the rule to try to prove that I'm wrong.

> Actually, it can even be threaded to the point where
> block allocations on the same filesystem can occur in
> parallel as long as it is being done for different
> block groups.

Prove it.  If you can code multi-threading SMP block and inode
allocation using a non-preemptive kernel (which Linux is) ON THE SAME
PARTITION, I will eat my hard drive.

