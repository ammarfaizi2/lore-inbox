Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310227AbSCFWnI>; Wed, 6 Mar 2002 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310228AbSCFWm6>; Wed, 6 Mar 2002 17:42:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49415 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310227AbSCFWmq>; Wed, 6 Mar 2002 17:42:46 -0500
Subject: Re: Probable Memory/VM issue.
To: petro@auctionwatch.com (Petro)
Date: Wed, 6 Mar 2002 22:57:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020306054143.GN22934@auctionwatch.com> from "Petro" at Mar 05, 2002 09:41:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ikLn-00004q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bogus stack limit or frame pointer, fp=0xbfabf8c0, stack_bottom=0xbfc7fcb8, thread_stack=65536, aborting backtrace.
> Trying to get some variables.
> Some pointers may be invalid and cause the dump to abort...
> thd->query at (nil)  is invalid pointer
> thd->thread_id=20479119

Which says nothing alas - nothing about user or kernel space. If the system
had run out of memory and killed it you'd have seen "killed" and an OOM
entry logged

Alan
