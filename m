Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276233AbRI1Sis>; Fri, 28 Sep 2001 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276232AbRI1Sii>; Fri, 28 Sep 2001 14:38:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53257 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276229AbRI1Si0>; Fri, 28 Sep 2001 14:38:26 -0400
Subject: Re: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
To: Martin.Bligh@us.ibm.com
Date: Fri, 28 Sep 2001 19:43:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <949648833.1001677028@[10.10.1.2]> from "Martin J. Bligh" at Sep 28, 2001 11:37:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n2bu-000805-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But this printk breaks a standard SMP machine without my patches (well,
> just this tiny printk part), not just the NUMA boxes ....

That makes the situation more interesting. Can you serialize the output
and see why ?
