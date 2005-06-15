Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVFOVjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFOVjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFOVew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:34:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261594AbVFOVe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:34:26 -0400
Date: Wed, 15 Jun 2005 14:30:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Fieroch <fieroch@web.de>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:
 nobody cared!"
Message-Id: <20050615143039.24132251.akpm@osdl.org>
In-Reply-To: <42B091EE.4020802@web.de>
References: <d6gf8j$jnb$1@sea.gmane.org>
	<20050527171613.5f949683.akpm@osdl.org>
	<429A2397.6090609@web.de>
	<58cb370e05061401041a67cfa7@mail.gmail.com>
	<42B091EE.4020802@web.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch <fieroch@web.de> wrote:
>
>  The "Integrated Technology Express, Inc. IT/ITE8212 Dual channel ATA
>  RAID controller" and a missing driver in the current kernel is
>  responsible for that problem.
> 
>  I've found a GPL ITE8212 driver at
>  ftp://ftp.asus.de/pub/ASUSCOM/TREIBER/CONTROLLER/IDE/ITE/ITE8212.zip
> 
>  The driver is compiling and working up to kernel 2.6.9.
>  With newer kernel versions I get following error while compiling:

hm, I thought Alan did a driver for the ITE RAID controller?

I had a driver from ITE in the -mm tree for a while.  It still seems to
apply and I think it fixes the compile warnings which you saw:


	http://www.zip.com.au/~akpm/linux/patches/stuff/iteraid.patch

