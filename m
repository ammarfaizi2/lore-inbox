Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293267AbSBWXjB>; Sat, 23 Feb 2002 18:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293269AbSBWXiw>; Sat, 23 Feb 2002 18:38:52 -0500
Received: from 1Cust225.tnt6.lax7.da.uu.net ([67.193.244.225]:6139 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S293267AbSBWXiq>; Sat, 23 Feb 2002 18:38:46 -0500
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
To: jamagallon@able.es (J.A. Magallon)
Date: Sat, 23 Feb 2002 15:39:49 -0800 (PST)
Cc: barryn@pobox.com (Barry K. Nathan), jamagallon@able.es (J.A. Magallon),
        linux-kernel@vger.kernel.org (Lista Linux-Kernel),
        rwhron@earthlink.net
In-Reply-To: <20020223104037.A5624@werewolf.able.es> from "J.A. Magallon" at Feb 23, 2002 10:40:37 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020223233949.02B7089C87@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> I vote for the sched-O1. The mount never gets rescheduled ????

Just one problem: I can reproduce this without sched-O1.

In fact, all I need is plain 2.4.17 + irqrate-A1. That's it. That's all I
need to get floppy accesses to hang 100% of the time. 2.4.17 without
irqrate does not have this problem.

(I haven't tried getting an oops with sysrq yet.)

-Barry K. Nathan <barryn@pobox.com>
