Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbRFCMEf>; Sun, 3 Jun 2001 08:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbRFCMAN>; Sun, 3 Jun 2001 08:00:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16147 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262868AbRFCLS1>; Sun, 3 Jun 2001 07:18:27 -0400
Subject: Re: What is i386 thread.trapno?
To: jdike@karaya.com (Jeff Dike)
Date: Sun, 3 Jun 2001 12:16:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106030231.VAA03708@ccure.karaya.com> from "Jeff Dike" at Jun 02, 2001 09:31:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156Vrd-0004Cq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The i386 page fault handler sets trap_no to 14, so the fault isn't coming from 
> there, but I can't see where a SIGSEGV is being delivered to a process with 
> thread.trap_no == 1.

include/asm-i386/siginfo.h

	
