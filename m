Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277393AbRJEOcX>; Fri, 5 Oct 2001 10:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277392AbRJEOcN>; Fri, 5 Oct 2001 10:32:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277393AbRJEObx>; Fri, 5 Oct 2001 10:31:53 -0400
Subject: Re: [PATCH] change name of rep_nop
To: paulus@samba.org
Date: Fri, 5 Oct 2001 15:37:30 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, benh@kernel.crashing.org
In-Reply-To: <15293.36735.916722.498977@cargo.ozlabs.ibm.com> from "Paul Mackerras" at Oct 05, 2001 08:46:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pW6U-0006Xx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a patch that addresses those three issues.  It adds an empty
> definition of cpu_relax for all architectures except x86 (for x86 it
> is defined to be rep_nop), and it changes smp_init to use a barrier
> instead of making wait_init_idle be volatile.
> 

Looks good to me
