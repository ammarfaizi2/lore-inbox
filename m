Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274233AbRISWet>; Wed, 19 Sep 2001 18:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274235AbRISWej>; Wed, 19 Sep 2001 18:34:39 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.133]:2201 "EHLO
	continuum.cm.nu") by vger.kernel.org with ESMTP id <S274233AbRISWe1>;
	Wed, 19 Sep 2001 18:34:27 -0400
Date: Wed, 19 Sep 2001 15:34:41 -0700
From: Shane Wegner <shane@cm.nu>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010919153441.A30940@cm.nu>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>
User-Agent: Mutt/1.3.20i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting the same thing here.  At least it looks similar
though I'm not sure what's causing it.  Dual PIII 850, 1gb
ram, 300mb swap.

__alloc_pages: 0-order allocation failed (gfp=0x20/0) from
c012e052
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from
c012e052
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from
c012e052


On Wed, Sep 19, 2001 at 04:21:43PM +0200, Martin MOKREJ? wrote:
> Hi,
>   I tried 2.4.10-pre12 and run some mysql big tests (actually
> mysql/tests/fork_big.pl ). And, the load is coming up and down from 17 to
> 6 .... and now, it's 1.7 only and I see in dmesg:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012e3e2
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012e3e2

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
