Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264496AbRF1VrG>; Thu, 28 Jun 2001 17:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264506AbRF1Vq4>; Thu, 28 Jun 2001 17:46:56 -0400
Received: from [216.101.162.242] ([216.101.162.242]:40605 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S264496AbRF1Vqi>;
	Thu, 28 Jun 2001 17:46:38 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.42369.591343.725769@pizda.ninka.net>
Date: Thu, 28 Jun 2001 14:45:37 -0700 (PDT)
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: (reposting) how to get DMA'able memory within 4GB on 64-bit m
	achi ne
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


MEHTA,HIREN (A-SanJose,ex1) writes:
 > Then why do we have 64-bit dma_addr_t on ia64 ?

Because what the ia64 folks wanted to happen was to make the existing
pci DMA interfaces return 64-bit DAC addresses if the driver made a
certain call into the PCI subsystem first.

I am totally against this architecture, but this is no matter.

If you do nothing other than call the existing PCI dma interfaces, no
matter how things work in the future you will get 32-bit addresses.

Later,
David S. Miller
davem@redhat.com

