Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbTGHV61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbTGHV61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:58:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55197 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267700AbTGHV61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:58:27 -0400
Date: Tue, 08 Jul 2003 15:04:33 -0700 (PDT)
Message-Id: <20030708.150433.104048841.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, grundler@parisc-linux.org,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030708213427.39de0195.ak@suse.de>
References: <20030703212415.GA30277@wotan.suse.de>
	<20030707.191438.71104854.davem@redhat.com>
	<20030708213427.39de0195.ak@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Tue, 8 Jul 2003 21:34:27 +0200

   Do you know a common PCI block device that would benefit from this
   (performs significantly better with short sg lists)? It would be
   interesting to test.
   
%10 to %15 on sym53c8xx devices found on sparc64 boxes.
