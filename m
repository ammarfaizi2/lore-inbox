Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbTGBXmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265948AbTGBXmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:42:49 -0400
Received: from ns.suse.de ([213.95.15.193]:9230 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265947AbTGBXlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:41:55 -0400
Date: Thu, 3 Jul 2003 01:56:19 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andi Kleen <ak@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030702235619.GA21567@wotan.suse.de>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030702165510.GC11739@dsl2.external.hp.com> <1057180598.20318.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057180598.20318.32.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1.	We allocate pages in reverse order so most merges cant occur

I added an printk and I get quite a lot of merges during bootup
with normal IDE.

(sometimes 12+ segments) 

-Andi
