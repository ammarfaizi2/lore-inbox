Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130807AbQK1WZR>; Tue, 28 Nov 2000 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131194AbQK1WY5>; Tue, 28 Nov 2000 17:24:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17978 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130807AbQK1WYt>; Tue, 28 Nov 2000 17:24:49 -0500
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
To: baggins@sith.mimuw.edu.pl (Jan Rekorajski)
Date: Tue, 28 Nov 2000 21:54:00 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl> from "Jan Rekorajski" at Nov 28, 2000 09:43:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140shP-00055W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is RLIMIT_NPROC apllied to root(uid 0) processes? It's not kernel j=
> ob to
> prevent admin from shooting him/her self in the foot.
> 
> root should be able to do fork() regardless of any limits,
> and IMHO the following patch is the right thing.

This patch is bogus. root can always raise their limit. But having root
tasks by default not take out the box is good

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
