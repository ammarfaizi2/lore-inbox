Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbULPAgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbULPAgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbULPAeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:34:10 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43959 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262552AbULPARD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:17:03 -0500
Message-ID: <41C0D426.8090806@jp.fujitsu.com>
Date: Thu, 16 Dec 2004 09:17:42 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Dimitris Lampridis <labis@mhl.tuc.gr>
Cc: linux-os@analogic.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt lost
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>	 <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>	 <Pine.LNX.4.61.0412131141480.4429@chaos.analogic.com> <1103109084.3565.13.camel@naousa.mhl.tuc.gr>
In-Reply-To: <1103109084.3565.13.camel@naousa.mhl.tuc.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The only thing that didn't already exist in my code was
> pci_set_power_state(pdev, 0), but it did not make any difference. the
> problem persists. Do you think that there is a problem if I request the
> irq line after calling pci_enable_device()? I cannot think of anything
> else. Everything that you mentioned is already in my code, and yet I can
> see no interrupt. Maybe it has something to do with my HW / BIOS?
> 

You should call pci_enable_device() first, and then request the irq.

Thanks,
Kenji Kaneshige

