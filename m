Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUHXRk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUHXRk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266677AbUHXRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:40:29 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:24047 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266214AbUHXRk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:40:28 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
X-Message-Flag: Warning: May contain useful information
References: <20040819092654.27bb9adf.akpm@osdl.org>
	<200408230930.18659.bjorn.helgaas@hp.com>
	<20040823190131.GC1303@hygelac>
	<200408240926.42665.bjorn.helgaas@hp.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 24 Aug 2004 10:36:14 -0700
In-Reply-To: <200408240926.42665.bjorn.helgaas@hp.com> (Bjorn Helgaas's
 message of "Tue, 24 Aug 2004 09:26:42 -0600")
Message-ID: <52vff8phf5.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Aug 2004 17:36:14.0873 (UTC) FILETIME=[DACD3090:01C48A00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bjorn> To be pedantically clear about this, looking at
    Bjorn> pci_dev->irq before calling pci_enable_device() is
    Bjorn> *guaranteed* to fail, regardless of what the BIOS does.  So
    Bjorn> nvidia users will have to use "pci=routeirq" until there's
    Bjorn> a new version of the nvidia driver.

Terence, correct me if I'm wrong, but the change to add
pci_enable_device() goes in the part of the nvidia driver that has
source available.  So users can apply this patch themselves even
without another Nvidia release.

 - Roland
