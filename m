Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTDOV2L (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTDOV1P 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:27:15 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:56960
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264098AbTDOV1M 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:27:12 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA transfers in 2.5.67
References: <yw1x3ckjfs2v.fsf@zaphod.guide>
	<1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 23:38:14 +0200
In-Reply-To: <1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <yw1xy92be915.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > What do I need to do in a driver before doing DMA transfers to a PCI
> > card?  Using a driver that worked in 2.4 gives a throughput of only 10
> > MB/s in 2.5.67.  Is there some magic initialization that I have
> > missed?
> 
> Assuming your driver uses the new PCI api for DMA in 2.4/2.5 then there
> isnt really anything to watch. Is this on a box with > 800Mb of memory
> however ?

It's an Alpha with 768 MB.  Is it the pci_alloc_* functions you are
referring to?  I don't think they are used currently. How much memory
can these allocate?  I need chunks of up to 1 MB, not necessarily
phycically continuous.

What do those functions do that normal memory allocation does not?
Apart from setting up sg mappings, that is.

-- 
Måns Rullgård
mru@users.sf.net
