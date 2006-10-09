Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWJIXZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWJIXZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 19:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWJIXZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 19:25:26 -0400
Received: from ozlabs.org ([203.10.76.45]:20363 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751928AbWJIXZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 19:25:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17706.55901.756032.880268@cargo.ozlabs.ibm.com>
Date: Tue, 10 Oct 2006 09:25:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Judith Lebzelter <judith@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
In-Reply-To: <Pine.LNX.4.64.0610041510400.24183@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net>
	<Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
	<1159849491.5482.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
	<1159867180.5482.61.camel@localhost.localdomain>
	<Pine.LNX.4.64.0610031023100.13141@skynet.skynet.ie>
	<1159877552.5482.69.camel@localhost.localdomain>
	<20061003130457.GA17358@skynet.ie>
	<1159932158.8469.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0610041510400.24183@skynet.skynet.ie>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman writes:

> The patch has passed tests here on x86, x86_64, ia64 and ppc64. Testing on 
> powerpc with HIGHMEM is a configuration I cannot test. If you say it 
> passes, I'll see can I get it pushed before 2.6.19-rc1

Seems fine on my powerbook with 1G of RAM, with 768M lowmem and 256M
highmem.

Paul.
