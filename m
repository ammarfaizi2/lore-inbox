Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030812AbWJDKvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030812AbWJDKvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030811AbWJDKvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:51:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40636 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030806AbWJDKvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:51:48 -0400
Subject: Re: PCI/IDE generic IDE driver + bus master DMA logic errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: girish <girishvg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com>
References: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 12:17:25 +0100
Message-Id: <1159960645.25772.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 19:07 +0900, ysgrifennodd girish:
> our hardware guys are designing an pci/ide controller which has  
> interrupt wrapper such that the ide & bus master interrupts are  
> packaged & delivered together.

All the SFF8038i/D1510 style devices have a single interrupt line for
IDE and for bus mastering interrupts. If your device behaves in
accordance to D1510 the default code ought to work.

Alan

