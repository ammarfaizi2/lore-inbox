Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTH3XeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTH3XeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:34:04 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:25528 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262258AbTH3Xd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:33:57 -0400
Subject: Re: [parisc-linux] Security Hole in binfmt_som.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>,
       parisc-linux@lists.parisc-linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030830135933.GJ13467@parcelfarce.linux.theplanet.co.uk>
References: <3F509BBD.2040007@hrzpub.tu-darmstadt.de>
	 <20030830131541.GI13467@parcelfarce.linux.theplanet.co.uk>
	 <1062251389.31150.4.camel@dhcp23.swansea.linux.org.uk>
	 <20030830135933.GJ13467@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062286379.31332.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 00:33:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-30 at 14:59, Matthew Wilcox wrote:
> Um, I can't find it, and neither can Google:
> http://www.google.com/search?q=binfmt_som+security&as_q=%5Bparisc-linux&btnG=Google+Search&as_sitesearch=lists.parisc-linux.org

Humm I thought it was on this list. Maybe lkml then

Whatever the basic problem is we have kernel loaders and
user threads sharing a file table unsafely

