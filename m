Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271389AbTHMLQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271685AbTHMLQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:16:45 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:9720 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271389AbTHMLQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:16:44 -0400
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Niehusmann <jan@gondor.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813080309.GB2006@gondor.com>
References: <20030806150335.GA5430@gondor.com>
	 <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>
	 <20030813005057.A1863@pclin040.win.tue.nl>
	 <200308130221.26305.bzolnier@elka.pw.edu.pl>
	 <20030813080309.GB2006@gondor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060773360.8009.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 12:16:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, it doesn't seem to work well. The hard disk only gives
> 20MB/s on sequential read (Seagate Baraccuda 160GB should be faster,
> right?), and hdparm -I /dev/hde completely locks up the whole computer -
> no console message at all, only hard reset helps. I need to get this
> running before I can try kernel patches for the LBA48 stuff.

That sounds about right for UDMA33, which is what you'd get without the
fix I sent Marcelo a few days ago

