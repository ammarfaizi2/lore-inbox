Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWHQTa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWHQTa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWHQTa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:30:26 -0400
Received: from khc.piap.pl ([195.187.100.11]:42683 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751258AbWHQTa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:30:26 -0400
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 50/75] net: drivers/net/wan/pci200syn.c pci_module_init to pci_register_driver conversion
References: <20060817132854.50.mHRHNx4920.3636.michal@euridica.enternet.net.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 17 Aug 2006 21:30:19 +0200
In-Reply-To: <20060817132854.50.mHRHNx4920.3636.michal@euridica.enternet.net.pl> (Michal Piotrowski's message of "Thu, 17 Aug 2006 13:28:54 +0000")
Message-ID: <m3psez5fec.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> writes:

> +++ linux-work2/drivers/net/wan/wanxl.c
> +++ linux-work2/drivers/net/wan/pci200syn.c

> -	return pci_module_init(&pci200_pci_driver);
> +	return pci_register_driver(&pci200_pci_driver);

Ok. Rozumiem, ze Jeff zrobi to w jednym, duzym batchu?
-- 
Krzysztof Halasa
