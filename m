Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbRFTWNr>; Wed, 20 Jun 2001 18:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264645AbRFTWNm>; Wed, 20 Jun 2001 18:13:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264642AbRFTWNd>; Wed, 20 Jun 2001 18:13:33 -0400
Subject: Re: Linux 2.4.5-ac16 kernel panic
To: admin@netpathway.com ("Gary White (Network Administrator)")
Date: Wed, 20 Jun 2001 23:12:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B3116A3.E89360DE@netpathway.com> from "Gary White (Network Administrator)" at Jun 20, 2001 04:33:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CqDS-0000DG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.5-ac16 patch applied to clean 2.4.5 tree. 2.4.5-ac15 boots
> with no problem.

Yes I screwed up the bootflag handling

> EIP:    0010:[<c01112cf>]
> EFLAGS: 00010286
> eax: 007ec000   ebx: e0800000   ecx: 3f7ec000   edx: c0101000

Can you build with kernel debug enabled and then say Y to all the debug options
and give me the BUG() message where that next build dies. I think I know whats
up I want to be sure


