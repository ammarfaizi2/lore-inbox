Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136072AbREGKdY>; Mon, 7 May 2001 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbREGKdO>; Mon, 7 May 2001 06:33:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15880 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136072AbREGKdF>; Mon, 7 May 2001 06:33:05 -0400
Subject: Re: 2.2.20pre1: Problems with SMP
To: shane@cm.nu (Shane Wegner)
Date: Mon, 7 May 2001 11:36:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010506175050.A1968@cm.nu> from "Shane Wegner" at May 06, 2001 05:50:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wiNn-0003JF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just booted up 2.2.20pre1 and am getting some funny
> results.  The system boots but is very slow.  Every few
> seconds I get:
> Stuck on TLB IPI wait (CPU#0)
> 
> Booting vanilla 2.2.19 works fine.  The machine is an
> Intel Pentium III 850MHZ on an Abit VP6 board.  If any
> further information is needed, let me know.

Can you back out the change to io_apic.c and tell me if that fixes it. If so
let Johannes Erdfelt and I know.

