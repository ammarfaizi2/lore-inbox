Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316087AbSEJT2I>; Fri, 10 May 2002 15:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316091AbSEJT2H>; Fri, 10 May 2002 15:28:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316087AbSEJT2H>; Fri, 10 May 2002 15:28:07 -0400
Subject: Re: x86 question: Can a process have > 3GB memory?
To: davidsen@tmr.com (Bill Davidsen)
Date: Fri, 10 May 2002 20:42:46 +0100 (BST)
Cc: rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (Linux-Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1020510145244.14035A-100000@gatekeeper.tmr.com> from "Bill Davidsen" at May 10, 2002 03:07:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E176GHv-0006ee-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel. It would be possible to allow program access to this RAM, although
> both Kernel and gcc support would be needed. M$ had "huge" memory models
> to go over 64k in the old 8086 days, doing loads of segment registers.

Alas that is not quite the case. You still have a 4Gb virtual address
space. If you want > 32bits, get a > 32bit processor. This one isnt as
simple as add segmentation and 'large model'
