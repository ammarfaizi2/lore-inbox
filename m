Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284090AbRLGRUS>; Fri, 7 Dec 2001 12:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284134AbRLGRUI>; Fri, 7 Dec 2001 12:20:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59916 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284090AbRLGRT7>; Fri, 7 Dec 2001 12:19:59 -0500
Subject: Re: Problem Compiling iph5526 module
To: wambolt@sysadminzone.com (David Wambolt)
Date: Fri, 7 Dec 2001 17:29:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112080841510.14757-100000@defiant.sysadminzone.com> from "David Wambolt" at Dec 08, 2001 08:44:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16COo9-0006Yf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 7.3 for Sparc.  Everything runs great, except it does not come with a
> precompiled version of the Interphase 5526 Fibre Channel module.  So I
> figured I'd download the 2.4.16 kernel, enable the module and recompile
> the kernel.  I've compiled kernels on x86 machines many times typically
> with no problems, or at least problems I could fix.

The 5526 driver doesn't currently support the sparc platform.

> depmod:         bus_to_virt_not_defined_use_pci_map
> depmod:         virt_to_bus_not_defined_use_pci_map

Its a deliberate error to indicate the driver uses old (and non portable)
interfaces.

Alan
