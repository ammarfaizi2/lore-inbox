Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbRF1XMx>; Thu, 28 Jun 2001 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264843AbRF1XMn>; Thu, 28 Jun 2001 19:12:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18194 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264848AbRF1XMc>; Thu, 28 Jun 2001 19:12:32 -0400
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Fri, 29 Jun 2001 00:11:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, bernds@redhat.com, FrankZhu@viatech.com.cn,
        linux-kernel@vger.kernel.org, mikpe@csd.uu.se
In-Reply-To: <200106282305.BAA17845@harpo.it.uu.se> from "Mikael Pettersson" at Jun 29, 2001 01:05:06 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fkwy-0007ps-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here I have to disagree with you Alan. When you pass "-march=i686" to
> gcc, you are _not_ saying "generate code for a CPUID family 6 CPU".
> "-march=i686" actually means "target an Intel P6 family chip, given
> what we currently know about them". The gcc info pages don't talk

Which is fine. The Pentium Pro manual explicitly states that cmov may go
away. So it is not based on what we know about the CPU, its based on not
reading the documentation. 

It's a bug. -march=i6868 does not 'target an Intel P6 family chip, ...'
It happens to work because the error in reading the docs was never triggered
by intel removing cmov from a cpu as the reserved the right to do

Alan


