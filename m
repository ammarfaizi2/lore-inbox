Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUGYPlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUGYPlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUGYPlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 11:41:49 -0400
Received: from loncoche.terra.com.br ([200.154.55.229]:46792 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S264054AbUGYPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 11:41:47 -0400
Subject: Re: High CPU usage for disk I/O while DMA is enabled
From: Rafael Pereira <gotrooted@pop.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
In-Reply-To: <20040725172533.672ad447@gasmaske>
References: <20040725130502.6e7f92f4@gasmaske>
	 <20040725145027.GB9404@ss1000.ms.mff.cuni.cz>
	 <20040725172533.672ad447@gasmaske>
Content-Type: text/plain
Message-Id: <1090770156.21875.2.camel@osts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 12:42:36 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-25 at 12:25, Nesimi Buelbuel wrote:

> actually I have compiled it into the Kernel.
> 
> here is a grep from all DMA related Kernel options:
> 
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_IDEDMA_ONLYDISK=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y

What is your motherboard ???
You must enable in .config the right IDE busmaster for your mobo.


Rafael.



