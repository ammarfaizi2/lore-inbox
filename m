Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311506AbSCNFKy>; Thu, 14 Mar 2002 00:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311507AbSCNFKo>; Thu, 14 Mar 2002 00:10:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18191 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311506AbSCNFK2>;
	Thu, 14 Mar 2002 00:10:28 -0500
Message-ID: <3C9030B8.1010300@mandrakesoft.com>
Date: Thu, 14 Mar 2002 00:10:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: gone@us.ibm.com
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] discontigmem support for ia32 NUMA box in 2.4.18
In-Reply-To: <200203140427.g2E4RPq23092@w-gaughen.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patricia Gaughen wrote:

>This patch depends on the patch I sent last week (Subject: [RFC]
>modularization of i386 setup_arch and mem_init in 2.4.18 -
>http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2) to
>lkml.  It is available for download at
>http://lse.sf.net/numa/discontig/memalloc-setup-2.4.18
>

Your "prep" patch for discontigmem seems pretty sane... but it's also a 
[relatively] big patch involving a pretty key piece of code.

I wonder if you could split the memalloc-setup patch into multiple 
steps, eventually arriving at your goal?

IMO it would be better to split up the memalloc-setup patch, apply it to 
2.5.x initially...

(sorry, no comments on your actual discontigmem patch :))

    Jeff




