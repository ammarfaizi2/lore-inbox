Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWIUKw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIUKw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 06:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWIUKw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 06:52:56 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:65511 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750803AbWIUKwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 06:52:55 -0400
Message-ID: <45126EF6.7060909@t-online.de>
Date: Thu, 21 Sep 2006 12:52:38 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060827)
MIME-Version: 1.0
To: Luke Yang <luke.adi@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/4] Blackfin: binfmt patch to enhance stacking checking
References: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
In-Reply-To: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bNvWMvZBgeaOn2uZa2ZV9Iw27dy5tye7Mq7rmYmCtD809pBlRmYlko
X-TOI-MSGID: cdc83e50-f5af-45b2-95a1-48d80569af9a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang wrote:
> 
> fs/binfmt_elf_fdpic.c       |    7 +-
> fs/binfmt_flat.c            |  150 
> ++++++++++++++++++++++++++------------------
> include/asm-arm/mmu.h       |    1
> include/asm-frv/mmu.h       |    1
> include/asm-h8300/mmu.h     |    1
> include/asm-m32r/mmu.h      |    1
> include/asm-m68knommu/mmu.h |    1
> include/asm-sh/mmu.h        |    1
> include/asm-v850/mmu.h      |    1
> include/linux/flat.h        |   13 ++-
> 10 files changed, 112 insertions(+), 65 deletions(-)

I've talked to Luke about this, and I think we'll scratch this last 
patch for now.  I'll resubmit something smaller in scale which has only 
the necessary bits to get flat binaries working on the Blackfin, without 
the stack checking bits.  That should make merging easier and we can add 
the extra features later.


Bernd
