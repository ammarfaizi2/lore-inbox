Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbTCTM4w>; Thu, 20 Mar 2003 07:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261439AbTCTM4w>; Thu, 20 Mar 2003 07:56:52 -0500
Received: from ppp-62-11-43-111.dialup.tiscali.it ([62.11.43.111]:2176 "EHLO
	Knoppix") by vger.kernel.org with ESMTP id <S261436AbTCTM4w>;
	Thu, 20 Mar 2003 07:56:52 -0500
Date: Thu, 20 Mar 2003 14:06:45 +0100
From: Mauro Chiarugi <vlaovic@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with pcmcia, pci and hard disk
Message-Id: <20030320140645.17be7381.vlaovic@libero.it>
In-Reply-To: <20030319173523.745fb4a9.maurochiarugi@tiscali.it>
References: <20030319173523.745fb4a9.maurochiarugi@tiscali.it>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've verified that my ram and hard disk are not bad.. i've used memtest
and disktest..

mmm

I think that it's a problem between my bios, my cardbus bridge (O2 Micro
OZ6912) that manage pcmcia, and my audio card. If pcmcia is enabled in
the kernel, all go straight.. if it isn't, there is a problem with
interrupts.. at the boot time, the kernel says that it waits irq 11 by
cardbus bridge but it receive irq 5. With the pcmcia support in the
kernel all go straight, but with lspci -v I can see that cardbus bridge
uses irq 5 (as my audio card)
