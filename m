Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSKZXzb>; Tue, 26 Nov 2002 18:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSKZXzZ>; Tue, 26 Nov 2002 18:55:25 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:60563 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261433AbSKZXyw>; Tue, 26 Nov 2002 18:54:52 -0500
Subject: Re: 2.5.49: "hdb: cannot handle device with more than 16 heads"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ebuddington@wesleyan.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021126150325.A157@ma-northadams1b-112.nad.adelphia.net>
References: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net>
	<1038335905.2658.65.camel@irongate.swansea.linux.org.uk> 
	<20021126150325.A157@ma-northadams1b-112.nad.adelphia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 00:33:23 +0000
Message-Id: <1038357203.2594.107.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 20:03, Eric Buddington wrote:
> Thanks. Disks and partitions are now recognized, but root still won't
> mount. Reiserfs (the root fs) is compiled in, along with IDE disk
> support.  I tried getting rid of the advanced partitopn types options,
> which eliminated the MS-DOS partition table message, but did not
> otherwise change things.
> 
> The hdc error is also unexpected, unless it's simply the result of no
> CD in the drive.
> 
> I hope this isn't another silly thing I'm missing.

I'd start by turning off devfs

