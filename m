Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTKUPcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 10:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTKUPcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 10:32:10 -0500
Received: from mail.g-housing.de ([62.75.136.201]:48802 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264351AbTKUPcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 10:32:07 -0500
Message-ID: <3FBE2FF4.5010904@g-house.de>
Date: Fri, 21 Nov 2003 16:32:04 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: russell@coker.com.au
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: de2104x tulip driver bug in 2.6.0-test9
References: <200311212051.32352.russell@coker.com.au>
In-Reply-To: <200311212051.32352.russell@coker.com.au>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Coker wrote:
> 00:14.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
> [Tulip Pass 3] (rev 11)
> 
> Above is the lspci output for my PCI Ethernet card.  Below is what happens 
> when I try to boot 2.6.0-test9.  2.4.x kernels have been working well on the 
> same card for a long time, so the hardware seems basically OK.
> 
> Configuring network interfaces... eth0: set link BNC
>  eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef09,0xfffff7fd,0xffff0006
>  eth0:    set mode 0x7ffc0000, set sia 0xef09,0xf7fd,0x6
>  eth0: timeout expired stopping DMA

could this be anyhow related to this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106766135110165&w=2

there is a thread on linuxppc-dev too, as this is ppc specific:

http://lists.linuxppc.org/linuxppc-dev/200311/msg00001.html

it looks similar, but here on ppc32 i got no oops :-(

Christian.
-- 
BOFH excuse #27:

radiosity depletion

