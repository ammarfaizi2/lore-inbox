Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbRFSPIT>; Tue, 19 Jun 2001 11:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFSPIJ>; Tue, 19 Jun 2001 11:08:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28943 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264260AbRFSPIB>; Tue, 19 Jun 2001 11:08:01 -0400
Subject: Re: PROBLEM: compiling with gcc 3.0
To: simonep@wseurope.com (Simone Piunno)
Date: Tue, 19 Jun 2001 16:07:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010619170235.C2593@pioppo.wired> from "Simone Piunno" at Jun 19, 2001 05:02:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CN5t-00066F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying to compile 2.4.5 with gcc 3.0 but there is a problem
> (conflicting type) between kernel/timer.c and include/linux/sched.h
> Apparently the problem solves with this oneline workarond:

Yep. Its fixed in the pre-patches I believe now. There are also a pile of
warning fixes that need to be merging.  I would still be very wary of relying
on a gcc 3.0.0 built kernel though

