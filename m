Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276049AbRJBRgQ>; Tue, 2 Oct 2001 13:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276050AbRJBRgG>; Tue, 2 Oct 2001 13:36:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276049AbRJBRf5>; Tue, 2 Oct 2001 13:35:57 -0400
Subject: Re: 2.4.10 hangs on console switch
To: larsch@cs.auc.dk (Lars Christensen)
Date: Tue, 2 Oct 2001 18:41:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0110021836001.15489-100000@peta.cs.auc.dk> from "Lars Christensen" at Oct 02, 2001 06:45:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oTXp-0005Mk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: Kernel 2.4.10 hangs when console is switched from X to text mode,
> either using C-A-Fn or when shutting down or reboot from X (with a black
> screen). 2.4.9 does not have this problem.
> 
> There is nothing about the hang in the log files. Kernel is configured for
> Athlon/K7 processor.

You are using the Nvidia drivers aren't you. They seem to have timing
dependant screen mode switch problems. The timing has changed in 2.4.10

Alan
