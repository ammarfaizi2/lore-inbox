Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291729AbSBXWtX>; Sun, 24 Feb 2002 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291741AbSBXWtM>; Sun, 24 Feb 2002 17:49:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291729AbSBXWtE>; Sun, 24 Feb 2002 17:49:04 -0500
Subject: Re: Flash Back -- kernel 2.1.111
To: paulus@samba.org
Date: Sun, 24 Feb 2002 23:01:57 +0000 (GMT)
Cc: vojtech@suse.cz (Vojtech Pavlik), hozer@drgw.net (Troy Benjegerdes),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        andre@linuxdiskcert.org (Andre Hedrick),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <15481.25250.869765.860828@argo.ozlabs.ibm.com> from "Paul Mackerras" at Feb 25, 2002 09:01:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16f7eX-0002yO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have some RS/6000 machines that have two separate PCI buses (two
> host bridges) that run at 33MHz and 50MHz respectively.  Fortunately
> we also get a device tree from the firmware that tells us this.

Ok - thats another argument for stuffing it in the pci_bus struct
