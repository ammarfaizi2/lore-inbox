Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWH2Ehc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWH2Ehc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWH2Ehc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:37:32 -0400
Received: from ozlabs.org ([203.10.76.45]:26073 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750786AbWH2Ehb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:37:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17651.50176.455224.734372@cargo.ozlabs.ibm.com>
Date: Tue, 29 Aug 2006 14:35:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Ronald Lee <Ronald_Lee@pmc-sierra.com>,
       Radjendirane Codandaramane 
	<Radjendirane_Codandaramane@pmc-sierra.com>,
       Shawn Jin <Shawn_Jin@pmc-sierra.com>
Subject: Re: PPC 2.6.11.4 kernel panics while doing insmod (store fault with d
	cbst in icache_flush_range)
In-Reply-To: <478F19F21671F04298A2116393EEC3D5540A32@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D5540A32@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kallol Biswas writes:

>         mr      r6,r3
> 1:      dcbst   0,r3
>         addi    r3,r3,L1_CACHE_LINE_SIZE
>         bdnz    1b
> 
> The instruction takes a store fault (DST bit, bit 8 of ESR gets
> set), kernel panics with oops (signal 11).

What processor are you using?

Which instruction takes a store fault?

Paul.
