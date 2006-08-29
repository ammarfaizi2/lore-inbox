Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWH2Rry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWH2Rry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWH2Rry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:47:54 -0400
Received: from brick.kernel.dk ([62.242.22.158]:1573 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965187AbWH2Rrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:47:53 -0400
Date: Tue, 29 Aug 2006 19:50:38 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] blktrace: cleanup using on_each_cpu
Message-ID: <20060829175038.GQ12257@kernel.dk>
References: <1156873612.2993.6.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156873612.2993.6.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29 2006, Martin Peschke wrote:
> This patch kills a few lines of code in blktrace by making use of
> on_each_cpu().
> 
> Patch against 2.6.18-rc4-mm3.
> (Tested with 2.6.17.11, though, as -rc4-mm3 refuses to come up on my
> s390 guest.)

Thanks Martin, applied!

-- 
Jens Axboe

