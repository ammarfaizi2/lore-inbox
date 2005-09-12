Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVILQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVILQzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVILQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:55:46 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2688 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751061AbVILQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:55:45 -0400
Subject: Re: PCI bug in 2.6.13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miguel <frankpoole@terra.es>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509110903050.4912@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
	 <20050909225956.42021440.akpm@osdl.org>
	 <20050910113658.178a7711.frankpoole@terra.es>
	 <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org>
	 <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
	 <20050911030814.08cbe74c.frankpoole@terra.es>
	 <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
	 <20050911161058.481d1a75.frankpoole@terra.es>
	 <Pine.LNX.4.58.0509110903050.4912@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 18:20:57 +0100
Message-Id: <1126545657.30449.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-11 at 09:08 -0700, Linus Torvalds wrote:
>         if (dev->resource[PCI_ROM_RESOURCE].start)
>                 pci_write_config_byte(dev, PCI_ROM_ADDRESS,
>                         dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> 
> I wonder how long that has been like that.

Since before 2.2. I've no docs on why it does it though

