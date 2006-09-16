Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWIPBGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWIPBGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 21:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWIPBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 21:06:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:61846 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750754AbWIPBGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 21:06:08 -0400
Subject: Re: [PATCH] via* : switch to pci_get_device refcounted PCI API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1158330577.29932.56.camel@localhost.localdomain>
References: <1158330577.29932.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 16 Sep 2006 11:05:42 +1000
Message-Id: <1158368742.14473.209.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 15:29 +0100, Alan Cox wrote:
> If we can clean up these remainders we can finally delete pci_find_*
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Note that I should probably revisit the via-pmu bits one of these days,
I don't think I need that save/restore of the config space of all PCI
devices anymore.

Cheers,
Ben.


