Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTG1LAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTG1LAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:00:08 -0400
Received: from ns.suse.de ([213.95.15.193]:19467 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262093AbTG1LAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:00:04 -0400
Date: Mon, 28 Jul 2003 13:15:13 +0200
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: davem@redhat.com, grundler@parisc-linux.org, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030728131513.5d4b1bd3.ak@suse.de>
In-Reply-To: <20030723114006.GA28688@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de>
	<20030708.150433.104048841.davem@redhat.com>
	<20030708222545.GC6787@dsl2.external.hp.com>
	<20030708.152314.115928676.davem@redhat.com>
	<20030723114006.GA28688@dsl2.external.hp.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 05:40:06 -0600
Grant Grundler <grundler@parisc-linux.org> wrote:


> 
> Andi, if you could pass me details about the "reaim new dbase" (ie how
> many devices I need, where to get it) I could make time to try that in
> the next couple of weeks.

Download reaim from sourceforge

Use the workfile.new_dbase test

Run it with 100-500 users (reaim -f workfile... -s 100 -e 500 -i 100) 

I tested with ext3 on a single SCSI disk.


-Andi

