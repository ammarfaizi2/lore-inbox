Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288045AbSACAIO>; Wed, 2 Jan 2002 19:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288062AbSACAG7>; Wed, 2 Jan 2002 19:06:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22544 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288057AbSACAGm>; Wed, 2 Jan 2002 19:06:42 -0500
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
To: harald.holzer@eunet.at (Harald Holzer)
Date: Thu, 3 Jan 2002 00:16:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        wookie@osdl.org (Timothy D. Witham)
In-Reply-To: <1010015450.15492.19.camel@hh2.hhhome.at> from "Harald Holzer" at Jan 03, 2002 12:50:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LvZ0-0006CX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 16GB ram, 269,424kB reserved
> 32GB ram, 532,080kB reserved, usable low mem: 352 MB
> 64GB ram ?? 

64Gb basically you can forget

> Which function does the reserved memory fulfill ?
> Is it all for paging ?

A lot of it is the page structs (64bytes per page - which really should be
nearer the 32 some rival Unix OS's achieve on x86)
