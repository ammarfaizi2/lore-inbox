Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSBUXLR>; Thu, 21 Feb 2002 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSBUXK5>; Thu, 21 Feb 2002 18:10:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287408AbSBUXKx>; Thu, 21 Feb 2002 18:10:53 -0500
Subject: Re: eepro100 (was Re: Linux 2.4.18-rc3)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 21 Feb 2002 23:25:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel list), netdev@oss.sgi.com
In-Reply-To: <3C75793B.1BFF7A1A@mandrakesoft.com> from "Jeff Garzik" at Feb 21, 2002 05:48:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16e2aJ-00007x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> eepro100 users,
> 
> If you can spare some time, please test and compare 2.4.17 and
> 2.4.18-rc3 kernel versions, for (a) regressions in performance/behavior,
> and (b) -fixed- or improved behavior.

Just glancing over the code - shouldnt it use pci_enable device before
checking the regions its assigned ?

Also it seems to include linux/delay.h twice

J Random Pedant
