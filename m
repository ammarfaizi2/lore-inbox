Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274271AbRIYAHX>; Mon, 24 Sep 2001 20:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274267AbRIYAHN>; Mon, 24 Sep 2001 20:07:13 -0400
Received: from ns.suse.de ([213.95.15.193]:4624 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274268AbRIYAG4>;
	Mon, 24 Sep 2001 20:06:56 -0400
Date: Tue, 25 Sep 2001 02:07:22 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compilation fix for nand.c
In-Reply-To: <3BAFC969.52B7FCDC@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.30.0109250205450.15679-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Eyal Lebedinsky wrote:

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.10/kernel/drivers/mtd/nand/nand.o
> depmod:         nand_calculate_ecc_R1f975137
> depmod:         nand_correct_data_Re756919d

*shrug*, I just made it get past my 'make everything build as a module'
test, but don't have hardware to test it.  Give dwmw2's patch a try
(url somewhere earlier in this thread), as that has more chance of being
complete.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

