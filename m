Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269553AbUIRPtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269553AbUIRPtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268750AbUIRPtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:49:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65497 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269564AbUIRPtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:49:06 -0400
Message-ID: <414C58E4.9090801@pobox.com>
Date: Sat, 18 Sep 2004 11:48:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] piix: Support 6300ESB SATA DMA adapter
References: <20040918073242.GA4928@darjeeling.triplehelix.org>
In-Reply-To: <20040918073242.GA4928@darjeeling.triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> Hello,
> 
> It turns out that the piix IDE driver works for PCI ID 8086:25a3
> (PCI_DEVICE_ID_INTEL_ESB_3) as well, per http://bugs.debian.org/254748,
> so this patch allows piix to recognize it automatically. Darik Horn
> originally wrote this patch.


Use CONFIG_SCSI_SATA instead...

	Jeff


