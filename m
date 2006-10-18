Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWJRHIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWJRHIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWJRHIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:08:44 -0400
Received: from brick.kernel.dk ([62.242.22.158]:35903 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750884AbWJRHIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:08:44 -0400
Date: Wed, 18 Oct 2006 09:09:22 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
Message-ID: <20061018070922.GB24452@kernel.dk>
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr> <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu> <Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr> <20061017193645.GM7854@kernel.dk> <Pine.LNX.4.61.0610172146450.928@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610172146450.928@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17 2006, Jan Engelhardt wrote:
> >> Never mind, I see that some filesystems have 'depends on BLOCK' instead 
> >> of being wrapped into if BLOCK. Not really consistent but whatever.
> >
> >Feel free to send in patches that make things more consistent.
> 
> How would you like things? if BLOCK or depends on BLOCK?

Well, if you can hide an entire block with if BLOCK, then that would be
preferred. Otherwise depends on BLOCK.

> Does menuconfig/oldconfig/etc. parse the whole config structure faster 
> it it done either way?

I'd be surprised if if BLOCK wasn't faster over, say, 10 depends on
BLOCK.

-- 
Jens Axboe

