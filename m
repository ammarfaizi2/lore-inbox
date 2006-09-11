Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWIKXzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWIKXzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWIKXzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:55:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21958 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965185AbWIKXzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:55:10 -0400
Message-ID: <4505F75A.80703@garzik.org>
Date: Mon, 11 Sep 2006 19:55:06 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 17/19] iop3xx: define IOP3XX_REG_ADDR[32|16|8] and clean
 up DMA/AAU defs
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231905.4737.15667.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231905.4737.15667.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Also brings the iop3xx registers in line with the format of the iop13xx
> register definitions.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  include/asm-arm/arch-iop32x/entry-macro.S |    2 
>  include/asm-arm/arch-iop32x/iop32x.h      |   14 +
>  include/asm-arm/arch-iop33x/entry-macro.S |    2 
>  include/asm-arm/arch-iop33x/iop33x.h      |   38 ++-
>  include/asm-arm/hardware/iop3xx.h         |  347 +++++++++++++----------------
>  5 files changed, 188 insertions(+), 215 deletions(-)

Another Linux mantra:  "volatile" == hiding a bug.  Avoid, please.

	Jeff



