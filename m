Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267768AbTGHWLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbTGHWLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:11:10 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:27665 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S267768AbTGHWLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:11:08 -0400
Date: Tue, 8 Jul 2003 16:25:45 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, grundler@parisc-linux.org,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030708222545.GC6787@dsl2.external.hp.com>
References: <20030703212415.GA30277@wotan.suse.de> <20030707.191438.71104854.davem@redhat.com> <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708.150433.104048841.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:04:33PM -0700, David S. Miller wrote:
>    Do you know a common PCI block device that would benefit from this
>    (performs significantly better with short sg lists)? It would be
>    interesting to test.
>    
> %10 to %15 on sym53c8xx devices found on sparc64 boxes.

Which workload?
I'd like to test this on our ia64 boxes.

thanks,
grant
