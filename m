Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVCOFSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVCOFSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVCOFSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:18:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:50877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262246AbVCOFST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:18:19 -0500
Date: Mon, 14 Mar 2005 21:17:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3: SIS5513 DMA problem (set_drive_speed_status)
Message-Id: <20050314211755.5e686c50.akpm@osdl.org>
In-Reply-To: <20050314161528.575f3a77@phoebee>
References: <20050314161528.575f3a77@phoebee>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>
> Hi,
> 
> just tried the 2.6.11-mm3 and at boot-time my start scripts try to
> enable DMA on my disk (hdparm -m16 -c1 -u1 -X69 /dev/hda).
> 
> But while running hdparm, the kernel waits many seconds and gives me
> some DMA warnings/errors:
>
> ...
>
> hda: set_drive_speed_status: status=0xd0 { Busy }
> 
> ide: failed opcode was: unknown
> hda: dma_timer_expiry: dma status == 0x41
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
> ...
> 
> That happened also with 2.6.11-rc3 since I thought I should switch away
> from my 2.6.8-rc2-mm1 (the best kernel ever ;)).

Could you please check whether 2.6.11-rc1 does this?  It should be released
mid-week.  Thanks.
