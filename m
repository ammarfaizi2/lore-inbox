Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288988AbSANJdm>; Mon, 14 Jan 2002 04:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288947AbSANJdc>; Mon, 14 Jan 2002 04:33:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36880 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288944AbSANJdU>; Mon, 14 Jan 2002 04:33:20 -0500
Subject: Re: ISA hardware discovery -- the elegant solution
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Mon, 14 Jan 2002 09:44:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0201141003190.28735-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Jan 14, 2002 10:03:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q3fX-0001Bt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You haven't taken into consideration that not many distributions have
> drivers in kernel, and in particular ISA device drivers. Namely because
> ISA probes are ugly and require frobbing of memory in the vague hopes of

Red Hat for one basically avoids ISA probing in favour of user guidance. We
also use a standard kernel build and the more I think about this the more
I think Erik's tool is trying to be too clever and should simply build 
a complete kernel set for the right cpu with the root fs and root fs block
device built into it
