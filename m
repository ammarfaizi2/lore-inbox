Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273995AbRIURV0>; Fri, 21 Sep 2001 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273990AbRIURVQ>; Fri, 21 Sep 2001 13:21:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59397 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273668AbRIURVK>; Fri, 21 Sep 2001 13:21:10 -0400
Subject: Re: [BUG] 2.4.10-pre13: ATM drivers cause panic
To: tip@prs.de
Date: Fri, 21 Sep 2001 18:25:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3BAB76A4.74B43FBD@internetwork-ag.de> from "Till Immanuel Patzschke" at Sep 21, 2001 07:19:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kU3r-0000bv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep 21 18:03:41 ipat01 kernel: invalid operand: 0000
> Sep 21 18:03:41 ipat01 kernel: CPU:    0
> Sep 21 18:03:41 ipat01 kernel: EIP:    0010:[atm_dev_register+289/308]
> Sep 21 18:03:41 ipat01 kernel: EFLAGS: 00010202

Thats confusing since I don't immediately see where the BUG() it hits is.
Can you rebuild with verbose kernel debugging enabled
	Kernel debugging = Y
	Verbose BUG() reporting = Y

Alan
