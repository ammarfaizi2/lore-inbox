Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUBNHYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 02:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUBNHYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 02:24:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9435 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264894AbUBNHYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 02:24:47 -0500
Date: Fri, 13 Feb 2004 23:24:40 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: dsaxena@plexity.net, mporter@kernel.crashing.org, lists@mdiehl.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040213232440.75f0595e.davem@redhat.com>
In-Reply-To: <20040213014953.GB25499@mail.shareable.org>
References: <20040211061753.GA22167@plexity.net>
	<Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
	<20040211111800.A5618@home.com>
	<20040211103056.69e4660e.davem@redhat.com>
	<20040211185725.GA25179@plexity.net>
	<20040211110853.492f479b.davem@redhat.com>
	<20040213014953.GB25499@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 01:49:53 +0000
Jamie Lokier <jamie@shareable.org> wrote:

> The names are a bit confusing.
> How about changing them to:
> 
>     pci_dma_sync_single         => pci_dma_sync_for_cpu
>     pci_dma_sync_device_single  => pci_dma_sync_for_device

Ok, but we have to keep pci_dma_sync_single around as an alias
to pci_dma_sync_for_cpu, at least for some time.


