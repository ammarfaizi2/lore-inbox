Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932137AbWFDGyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWFDGyR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 02:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWFDGyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 02:54:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:52953 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932154AbWFDGyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 02:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c3qq7xN0BwrrhWUxJW5E7nOV/p13+YQTicMs+Sb21yLEdzXM7kEEqLW9rC/vZhdoauAcv2/CNBMEc2smlSgNbZqe2jv0nvpv1TQNjhebUwCDRbIk3wh4TSAy9/k0TCpyOW6Sax3IdmN9ikp95i16pbAqxe2o9t0U3UziMBrtQvg=
Message-ID: <44828384.1080906@gmail.com>
Date: Sun, 04 Jun 2006 15:53:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: axboe@suse.de, James.Bottomley@SteelEye.com, davem@redhat.com,
        bzolnier@gmail.com, james.steward@dynamicratings.com,
        jgarzik@pobox.com, mattjreimer@gmail.com, g.liakhovetski@gmx.de,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5] arm: implement flush_kernel_dcache_page()
References: <1149392479501-git-send-email-htejun@gmail.com>	<1149392479281-git-send-email-htejun@gmail.com> <20060603.234517.104035250.davem@davemloft.net>
In-Reply-To: <20060603.234517.104035250.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Tejun Heo <htejun@gmail.com>
> Date: Sun, 4 Jun 2006 12:41:19 +0900
> 
>>  arch/sparc64/kernel/head.S            |   30 -------------------
>>  arch/sparc64/kernel/setup.c           |   23 ++++++++-------
>>  arch/sparc64/kernel/smp.c             |   16 ++++++++--
> 
> You're reverting a totally unrelated sparc64 bug fix
> in Linus's tree.
> 
> Be careful in how you generate your patches.

Yeap, HEAD and index got out of sync while fetching & checking out. 
I've sent a regenerated patch as a reply to the original message. 
Haven't you received it?

Sorry about the noise.

-- 
tejun
