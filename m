Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVAYOEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVAYOEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVAYOEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:04:02 -0500
Received: from mail0.lsil.com ([147.145.40.20]:55018 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261941AbVAYOD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:03:59 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Andi Kleen'" <ak@muc.de>, "'Steve Lord'" <lord@xfs.org>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Mel Gorman'" <mel@csn.ul.ie>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Memory Management List'" <linux-mm@kvack.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Grant Grundler'" <grundler@parisc-linux.org>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: [PATCH] Avoiding fragmentation through different allocator
Date: Tue, 25 Jan 2005 09:02:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> e.g. performance on megaraid controllers (very popular 
> because a big PC vendor ships them) was always quite bad on 
> Linux. Up to the point that specific IO workloads run half as 
> fast on a megaraid compared to other controllers. I heard 
> they do work better on Windows.
> 
<snip>
> Ideally the Linux IO patterns would look similar to the 
> Windows IO patterns, then we could reuse all the 
> optimizations the controller vendors did for Windows :)

LSI would leave no stone unturned to make the performance better for
megaraid controllers under Linux. If you have some hard data in relation to
comparison of performance for adapters from other vendors, please share with
us. We would definitely strive to better it.

The megaraid driver is open source, do you see anything that driver can do
to improve performance. We would greatly appreciate any feedback in this
regard and definitely incorporate in the driver. The FW under Linux and
windows is same, so I do not see how the megaraid stack should perform
differently under Linux and windows?

Thanks

Atul Mukker
Architect, Drivers and BIOS
LSI Logic Corporation
