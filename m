Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274262AbRIYADC>; Mon, 24 Sep 2001 20:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274267AbRIYACv>; Mon, 24 Sep 2001 20:02:51 -0400
Received: from CPE-61-9-148-139.vic.bigpond.net.au ([61.9.148.139]:36088 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274258AbRIYACt>; Mon, 24 Sep 2001 20:02:49 -0400
Message-ID: <3BAFC969.52B7FCDC@eyal.emu.id.au>
Date: Tue, 25 Sep 2001 10:01:45 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compilation fix for nand.c
In-Reply-To: <Pine.LNX.4.30.0109242233150.18098-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> nand.c uses do_softirq() without including interrupt.h.
> Patch below makes things compile again.

This is not a full solution though:

depmod: *** Unresolved symbols in
/lib/modules/2.4.10/kernel/drivers/mtd/nand/nand.o
depmod:         nand_calculate_ecc_R1f975137
depmod:         nand_correct_data_Re756919d

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
