Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315955AbSEGTav>; Tue, 7 May 2002 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315956AbSEGTau>; Tue, 7 May 2002 15:30:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27141 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315955AbSEGTat>; Tue, 7 May 2002 15:30:49 -0400
Subject: Re: Memory Barrier Definitions
To: engebret@vnet.ibm.com (Dave Engebretsen)
Date: Tue, 7 May 2002 20:49:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CD825E4.6950ED92@vnet.ibm.com> from "Dave Engebretsen" at May 07, 2002 02:07:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175AyE-0008NR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A solution was pointed out by Rusty Russell that we should probabily be
> using smp_*mb() for system memory ordering and reserve the *mb() calls

For pure compiler level ordering we have barrier()

Alan
 

