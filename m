Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVEZQDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVEZQDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVEZQDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:03:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:18865 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261586AbVEZQDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:03:07 -0400
Subject: Re: ide-cd problem in 2.6.12-rc5 + todays snapshot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.SOC.4.61.0505261816190.28439@math.ut.ee>
References: <Pine.SOC.4.61.0505261816190.28439@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117123245.5743.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 26 May 2005 17:00:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-05-26 at 16:31, Meelis Roos wrote:
> Background: I have a Sony CDU5211 CD drive with Intel D815EEA2 mainboard 
> (ICH2 IDE in 815 chipset). Since 2.4.21 timeframe IDE DMA for this CD 
> drive is broken (see my post 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/0480.html). This 
> happens on at least 2 identical machines. This is the first problem 
> (that I have learned to live with).
> 
> Now, since ide-cd dma is broken, the first access to cd always gets DMA 
> timeout and turns off DMA, then it works. I have hddtemp installed and 
> it probes for drives on boot. In 2.6.12 (and I think I tested pristine 
> 2.6.12-rc5 too) the cd works as before - dma timeout+disable on first 
> access (by hddtemp).

Ok that one is very different to the end of media bugs. 
