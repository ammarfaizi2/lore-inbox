Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUIPNCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUIPNCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUIPNCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:02:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268039AbUIPNAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:00:15 -0400
Date: Thu, 16 Sep 2004 14:58:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [2.6.8.1-ck7-web100] Badness in cfq_sort_rr_list
Message-ID: <20040916125824.GD3544@suse.de>
References: <1072359679.20040916142632@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072359679.20040916142632@dns.toxicfilms.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16 2004, Maciej Soltysiak wrote:
> Hi,
> 
> I have just had this:
> Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
> 
> [ more of the trace at http://dns.toxicfilms.tv/cfq.txt ]
> 
> On a 2.6.8.1 with:
> - patch-2.6.8.1-ck7.bz2
> - web100-2.5.0-200408311033.tar.gz
> 
> I know ck7 uses CFQ as deafult and that web100 touches only tcp stuff.

You can ignore it, it's harmless. Con has the extra updates to fix this,
they are also in 2.6.9-rc2-mm1 as posted by Andrew earlier today.

-- 
Jens Axboe

