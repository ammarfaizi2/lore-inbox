Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSJOH1A>; Tue, 15 Oct 2002 03:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263250AbSJOH1A>; Tue, 15 Oct 2002 03:27:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28387 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263246AbSJOH07>;
	Tue, 15 Oct 2002 03:26:59 -0400
Date: Tue, 15 Oct 2002 09:32:44 +0200
From: Jens Axboe <axboe@suse.de>
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide tcq support, 2.5.40-bk
Message-ID: <20021015073244.GD5294@suse.de>
References: <3DAB04BA.3F86E0A7@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB04BA.3F86E0A7@uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14 2002, David Balazic wrote:
> Jens Axboe wrote : 
> > Hi, 
> > 
> > 
> > Tagged command queueing support for IDE is available again. It has a few 
> > rough edges from a source style POV, nothing that should impact 
> > stability though. 
> 
> Does this include overlapping comand feature support ?
> How about support for ATAPI devices ?

No, the support is strictly for the queued feature set and it's even a
bit crippled compared to that. We really need host adapter autopoll for
a full fledged implementation.

-- 
Jens Axboe

