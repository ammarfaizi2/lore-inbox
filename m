Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132831AbRDDOzR>; Wed, 4 Apr 2001 10:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbRDDOzH>; Wed, 4 Apr 2001 10:55:07 -0400
Received: from [212.115.175.146] ([212.115.175.146]:33018 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S132831AbRDDOzC>; Wed, 4 Apr 2001 10:55:02 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F115B@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: David Weinehall <tao@acc.umu.se>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: random PIDs
Date: Wed, 4 Apr 2001 16:53:34 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Finished & tested my random PID kernel/fork.c:get_pid() replacement.
> This one keeps track of the last N (default is 64) pids who have exited.
> These are then not used. So, one cannot have more then 32767 - (64 + 1
> (init) + 1 (idle)) = 32761 processes :o)
DW> Huh, should be 32701, right?!

You're absolutely right. It must've been the victory trance :o)
