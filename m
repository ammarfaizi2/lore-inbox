Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272967AbTG3QgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272969AbTG3QgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:36:20 -0400
Received: from ns.suse.de ([213.95.15.193]:16388 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272968AbTG3QgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:36:17 -0400
Date: Wed, 30 Jul 2003 18:36:15 +0200
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030730163615.GD17201@wotan.suse.de>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com> <20030723114006.GA28688@dsl2.external.hp.com> <20030728131513.5d4b1bd3.ak@suse.de> <20030730044256.GA1974@dsl2.external.hp.com> <20030729215118.13a5ac18.davem@redhat.com> <20030730160250.GA16960@dsl2.external.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730160250.GA16960@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 10:02:50AM -0600, Grant Grundler wrote:
> On Tue, Jul 29, 2003 at 09:51:18PM -0700, David S. Miller wrote:
> > Make an ext2 filesystem with 16K blocks :-)
> 
> Executive summary:
> 	looks the same as previous 4k block/16k page w/VMERGE enabled.
> 
> davem, I thought you were joking...I've submitted a oneliner to
> Ted Tyso to increase EXT2_MAX_BLOCK_LOG_SIZE to 64k.
> kudos to willy for quickly digging this up.
> 16k block size Works For Me (tm).
> 
> appended is the re-aim-7 results for 16k page/block on ext2.

The differences were greater with the mpt fusion driver, maybe it has
more overhead. Or your IO subsystem is significantly different.

-Andi
