Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272731AbTG3Ey4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 00:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272735AbTG3Ey4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 00:54:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7111 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272731AbTG3Eyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 00:54:55 -0400
Date: Tue, 29 Jul 2003 21:51:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: ak@suse.de, grundler@parisc-linux.org, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030729215118.13a5ac18.davem@redhat.com>
In-Reply-To: <20030730044256.GA1974@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de>
	<20030708.150433.104048841.davem@redhat.com>
	<20030708222545.GC6787@dsl2.external.hp.com>
	<20030708.152314.115928676.davem@redhat.com>
	<20030723114006.GA28688@dsl2.external.hp.com>
	<20030728131513.5d4b1bd3.ak@suse.de>
	<20030730044256.GA1974@dsl2.external.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 22:42:56 -0600
Grant Grundler <grundler@parisc-linux.org> wrote:

> On Mon, Jul 28, 2003 at 01:15:13PM +0200, Andi Kleen wrote:
> > Run it with 100-500 users (reaim -f workfile... -s 100 -e 500 -i 100) 
> 
> jejb was wondering if 4k pages would cause different behaviors becuase
> of file system vs page size (4k vs 16k).  ia64 uses 16k by default.
> I've rebuilt the kernel with 4k page size and VMERGE != 0.
> The substantially worse performance feels like a rat hole because
> of 4x pressure on CPU TLB.

Make an ext2 filesystem with 16K blocks :-)
