Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTH3Nuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTH3Nuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:50:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:27573 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261761AbTH3Nut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:50:49 -0400
Subject: Re: [parisc-linux] Security Hole in binfmt_som.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>,
       parisc-linux@lists.parisc-linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030830131541.GI13467@parcelfarce.linux.theplanet.co.uk>
References: <3F509BBD.2040007@hrzpub.tu-darmstadt.de>
	 <20030830131541.GI13467@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062251389.31150.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sat, 30 Aug 2003 14:49:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-30 at 14:15, Matthew Wilcox wrote:
> On Sat, Aug 30, 2003 at 02:42:37PM +0200, Ruediger Scholz wrote:
> > binfmt_som.c:216:2: #error "Fix security hole before enabling me"
> > What's this message about?
> 
> I don't know.  I wish someone would tell me.  You'd think they'd have the
> decency to contact the person listed as the author at the top of the file.

Actually explanations were posted in the previous discussion on this on
parisc-list.

Someone has to do the equivalent of the 2.4.22 binfmt_elf changes if
neccessary so that another thread can't change the file handles or 
steal the exec fd being passed to the loader.

