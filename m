Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292522AbSCOOPL>; Fri, 15 Mar 2002 09:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSCOOPC>; Fri, 15 Mar 2002 09:15:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292522AbSCOOOq>; Fri, 15 Mar 2002 09:14:46 -0500
Subject: Re: 2.4.18 Preempt Freezeups
To: ian@ianduggan.net (Ian Duggan)
Date: Fri, 15 Mar 2002 14:30:29 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <3C91B2A1.48C74B82@ianduggan.net> from "Ian Duggan" at Mar 15, 2002 12:36:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lsiz-0003ly-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "This kernel module attempts to isolate all of the functions and
> structures that NeTraverse utilizes in it's binary kernel modules."
> 
> The win4lin patch (also GPL) provides hooks for the mki-adapter module
> to call.

Not really. Because if the win4lin patch provides hooks for binary modules
that the binary modules depend upon then its hard to see how the two are
resolvable. Either its GPL , in which case why is nonGPL code dependant
on it and not shipped GPL, or it isnt

> I'm not asking for help fixing it, because of the binary module issue.
> I'm just looking for ways to narrow down where the problem might be,
> given that the machine completely locks up.

I've also seen the win4lin patch. I really don't envy anyone trying to
debug it
