Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUC2PCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUC2PCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:02:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51665 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262918AbUC2PBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:01:40 -0500
Date: Mon, 29 Mar 2004 17:01:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Zoltan NAGY <nagyz@nefty.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush and dm-crypt
Message-ID: <20040329150137.GH24370@suse.de>
References: <1067885681.20040329165002@nefty.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067885681.20040329165002@nefty.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2004, Zoltan NAGY wrote:
> Hi!
> 
> I've just upgraded the system to 2.6.5-rc2-bk6, and I'm using
> dm-crypt. It's a heavily used server, on average 20-30mbit/sec
> traffic is on the wire 7/24, and just noticed, that the load is very
> high. In every 4-5 sec pdflush takes a lot of cpu... Is this
> intentional? I've found a similar question on kerneltrap
> (http://kerneltrap.org/node/view/2756), but havent found a solution
> yet. I'm just wondering if it is a problem, or it's the normal
> behavior? It's a 1.8 P4 with 1G ram and highmem enabled, with 256 bit
> aes thru dm-crypt.

Try the -mm kernels intead, should have lots better behaviour for
pdflush/dm interactions.

-- 
Jens Axboe

