Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSGPJTG>; Tue, 16 Jul 2002 05:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSGPJTF>; Tue, 16 Jul 2002 05:19:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27343 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312601AbSGPJTE>;
	Tue, 16 Jul 2002 05:19:04 -0400
Date: Tue, 16 Jul 2002 11:21:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716092150.GS811@suse.de>
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de> <3D33DED8.C5C92C06@zip.com.au> <20020716085233.GA1096@holomorphy.com> <3D33E532.E078914E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D33E532.E078914E@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16 2002, Andrew Morton wrote:
> btw, Jens: where do the pages which bio_copy allocates get freed?

loop_end_io_transfer -> loop_put_buffer

-- 
Jens Axboe

