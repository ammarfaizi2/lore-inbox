Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSCXTeK>; Sun, 24 Mar 2002 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311872AbSCXTeA>; Sun, 24 Mar 2002 14:34:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39184 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311871AbSCXTdw>; Sun, 24 Mar 2002 14:33:52 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Sun, 24 Mar 2002 19:50:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <3C9E1BD1.6040405@freenet.de> from "Andreas Hartmann" at Mar 24, 2002 07:32:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pE0U-00073m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My system cannot (short of a bug) go OOM. Thats what the new overcommit
> > mode 2/3 ensures
> 
> How does a process react that doesn't get no more memory?

Thats up to the process. If a program doesn't handle malloc/mmap/etc
failures then its junk anyway
