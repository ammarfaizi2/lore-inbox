Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSIFPYm>; Fri, 6 Sep 2002 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSIFPYm>; Fri, 6 Sep 2002 11:24:42 -0400
Received: from 62-190-217-14.pdu.pipex.net ([62.190.217.14]:40452 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318721AbSIFPYl>; Fri, 6 Sep 2002 11:24:41 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209061536.g86FaniW004326@darkstar.example.net>
Subject: Re: ide drive dying?
To: devilkin-lkml@blindguardian.org (DevilKin)
Date: Fri, 6 Sep 2002 16:36:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209061713.51387.devilkin-lkml@blindguardian.org> from "DevilKin" at Sep 06, 2002 05:13:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've looked up these errors on the net, and as far as i can tell it means
> that the drive has some bad sectors at the given addresses and that it will
> probably die on me sooner or later.
> 
> Can someone either confirm this to me or tell me what to do to fix it?
> 
> The drive involved is an IBM-DTLA-307060, which has served me without
> problems now for about 2 years.

Have a look at:

http://csl.cse.ucsc.edu/smart.shtml

there you will find software for interrogating and monitoring the S.M.A.R.T. data available from your drive.  It's a little late to start monitoring it, if the drive is already dying, but if, for example, it shows a lot of re-allocated sectors, or spin retries, you'll know something is wrong.

John.
