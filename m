Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUGYP0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUGYP0E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUGYPZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 11:25:50 -0400
Received: from pop.gmx.de ([213.165.64.20]:61884 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264085AbUGYPZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 11:25:39 -0400
X-Authenticated: #1489797
Date: Sun, 25 Jul 2004 17:25:33 +0200
From: Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: High CPU usage for disk I/O while DMA is enabled
Message-Id: <20040725172533.672ad447@gasmaske>
In-Reply-To: <20040725145027.GB9404@ss1000.ms.mff.cuni.cz>
References: <20040725130502.6e7f92f4@gasmaske>
	<20040725145027.GB9404@ss1000.ms.mff.cuni.cz>
X-Mailer: nc (Brain)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 16:50:27 +0200
Rudo Thomas <rudo@matfyz.cz> wrote:

> Maybe you don't have the right IDE driver configured
> (CONFIG_BLK_DEV_*)...

actually I have compiled it into the Kernel.

here is a grep from all DMA related Kernel options:

CONFIG_GENERIC_ISA_DMA=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y


Nesimi

