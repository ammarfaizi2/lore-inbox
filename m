Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUJLPvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUJLPvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUJLPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:51:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61325 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265795AbUJLPvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:51:41 -0400
Message-ID: <416BFD79.1010306@pobox.com>
Date: Tue, 12 Oct 2004 11:51:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hirokazu Takata <takata@linux-m32r.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
References: <20041012.195043.137811384.takata.hirokazu@renesas.com>
In-Reply-To: <20041012.195043.137811384.takata.hirokazu@renesas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata wrote:
> Just fix compile error of drivers/net/smc91x.c for m32r.
> 
> It seems the previous patch (m32r-trivial-fix-of-smc91xh.patch) is too old. 
> So I will send a new patch.
> 
> Please drop the previous patch
> ( $ patch -R1 -p1 <m32r-trivial-fix-of-smc91xh.patch )
> and apply the new one.
> 
> 	* drivers/net/smc91x.h:
> 	- Add set_irq_type() macro to ignore it for m32r.
> 	- Fix RPC_LSA_DEFAULT and RPC_LSB_DEFAULT for an M3T-M32700UT board.
> 
> Thanks.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>

Seems OK to me, I'll put it into my netdev queue.

For net driver patches, please always CC
* netdev@oss.sgi.com, and
* jgarzik@pobox.com

	Jeff



