Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316612AbSEUVY4>; Tue, 21 May 2002 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSEUVY4>; Tue, 21 May 2002 17:24:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23305 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316612AbSEUVYy>; Tue, 21 May 2002 17:24:54 -0400
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
To: camhanaich99@yahoo.com (Erik McKee)
Date: Tue, 21 May 2002 22:38:08 +0100 (BST)
Cc: wli@holomorphy.com (William Lee Irwin III), linux-kernel@vger.kernel.org
In-Reply-To: <20020521202351.42147.qmail@web14202.mail.yahoo.com> from "Erik McKee" at May 21, 2002 01:23:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AHKa-0000Hr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's preempt-kernel-rml-2.4.19-pre8-ac1-1.patch from
> http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/linux-2.4/preempt-kernel-rml-2.4.19-pre8-ac1-1.patch
> 
> It applied cleanly with no mods needed and had been running fine untill this
> decided to happen.  Seems like slocate's updatedb decided to jack the load up
> which triggered oom?  However, the chosen process was unkillable since its the
> same process listed in the oom report over and over again?

Can you repeat the problem without pre-empt ?
