Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRDJLy2>; Tue, 10 Apr 2001 07:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbRDJLyS>; Tue, 10 Apr 2001 07:54:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:517 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131484AbRDJLyF>; Tue, 10 Apr 2001 07:54:05 -0400
Subject: Re: No 100 HZ timer !
To: schwidefsky@de.ibm.com
Date: Tue, 10 Apr 2001 12:54:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        linux-kernel@vger.kernel.org
In-Reply-To: <C1256A2A.003FF1BD.00@d12mta07.de.ibm.com> from "schwidefsky@de.ibm.com" at Apr 10, 2001 01:38:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mwj5-00046a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you do the accounting on reschedule, how do you find out how much ti=
> me
> has been spent in user versus kernel mode? Or do the Intel chips have t=
> wo
> counters, one for user space execution and one for the kernel?

Unfortunately not so you'd need to do a little bit per syscall, at least for
non trivial syscalls.
