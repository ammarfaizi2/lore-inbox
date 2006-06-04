Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932127AbWFDGpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWFDGpV (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 02:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWFDGpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 02:45:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26584
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932127AbWFDGpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 02:45:19 -0400
Date: Sat, 03 Jun 2006 23:45:17 -0700 (PDT)
Message-Id: <20060603.234517.104035250.davem@davemloft.net>
To: htejun@gmail.com
Cc: axboe@suse.de, James.Bottomley@SteelEye.com, davem@redhat.com,
        bzolnier@gmail.com, james.steward@dynamicratings.com,
        jgarzik@pobox.com, mattjreimer@gmail.com, g.liakhovetski@gmx.de,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5] arm: implement flush_kernel_dcache_page()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1149392479281-git-send-email-htejun@gmail.com>
References: <1149392479501-git-send-email-htejun@gmail.com>
	<1149392479281-git-send-email-htejun@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Jun 2006 12:41:19 +0900

>  arch/sparc64/kernel/head.S            |   30 -------------------
>  arch/sparc64/kernel/setup.c           |   23 ++++++++-------
>  arch/sparc64/kernel/smp.c             |   16 ++++++++--

You're reverting a totally unrelated sparc64 bug fix
in Linus's tree.

Be careful in how you generate your patches.

Thanks :)
