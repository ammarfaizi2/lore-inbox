Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWHUH51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWHUH51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWHUH51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:57:27 -0400
Received: from brick.kernel.dk ([62.242.22.158]:15655 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030300AbWHUH50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:57:26 -0400
Date: Mon, 21 Aug 2006 09:59:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-ID: <20060821075936.GQ4290@suse.de>
References: <20060819220008.843d2f64.akpm@osdl.org> <6bffcb0e0608200630h40d2b07v1db22d19753734be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608200630h40d2b07v1db22d19753734be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20 2006, Michal Piotrowski wrote:
> On 20/08/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> >
> 
> 0kB Cache?
> 
> hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hdd: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> 
> It should be 2048kB
> 
> Aug 20 14:28:07 euridica kernel: hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW
> drive, 2048kB Cache, UDMA(33)
> Aug 20 14:28:07 euridica kernel: Uniform CD-ROM driver Revision: 3.20
> Aug 20 14:28:07 euridica kernel: hdd: ATAPI 52X CD-ROM CD-R/RW drive,
> 2048kB Cache, UDMA(33)
> 
> config & dmesg -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm2/

Does 2.6.18-rc4 correctly identify the cache size? If so, this smells
like another out fall from the rq-cmd-type patch.

-- 
Jens Axboe

