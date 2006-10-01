Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWJALcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWJALcj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWJALcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:32:39 -0400
Received: from brick.kernel.dk ([62.242.22.158]:14700 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751752AbWJALci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:32:38 -0400
Date: Sun, 1 Oct 2006 13:32:02 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD drive lost DVD capabilities in current git tree
Message-ID: <20061001113201.GT5670@kernel.dk>
References: <20061001112333.GA15311@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001112333.GA15311@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01 2006, Olaf Hering wrote:
> 
> Current git tree does not detect the DVD drive in the G5 anymore:
> 
> -Linux version 2.6.18-g5-g5ffd1a6a (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #61 SMP Sat Sep 30 19:16:58 CEST 2006
> +Linux version 2.6.18-g5-g82965add (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #62 SMP Sun Oct 1 11:41:42 CEST 2006
> 
>  Probing IDE interface ide0...
>  hda: HL-DT-ST DVD-RW GWA-4165B, ATAPI CD/DVD-ROM drive
>  hda: Enabling Ultra DMA 4
>  ide0 at 0xd00008008730e000-0xd00008008730e007,0xd00008008730e160 on irq 38
> -hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
> +hda: ATAPI CD-ROM drive, 0kB Cache, UDMA(66)

Funky, I thought that bug was squashed many weeks ago. I'll get this
fixed up.

-- 
Jens Axboe

