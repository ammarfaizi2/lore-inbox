Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265542AbUF2IYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbUF2IYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265574AbUF2IYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:24:13 -0400
Received: from av.isp.contactel.cz ([212.65.193.174]:4068 "EHLO
	av4.isp.contactel.cz") by vger.kernel.org with ESMTP
	id S265542AbUF2IYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:24:09 -0400
Date: Tue, 29 Jun 2004 10:24:05 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3512 & seagate ST3120026AS in 2.4.27-rc2
Message-ID: <20040629082405.GA22226@kangaroo.instrat.cz>
References: <20040629060900.GA20895@kangaroo.instrat.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629060900.GA20895@kangaroo.instrat.cz>
User-Agent: Mutt/1.4.1i
X-Operating-System: athlon i686 Linux-2.4.20-28.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I have sil3512 controller and 2x Seagate ST3120026AS (yes, with mod15
> problem...) discs. When i try some writes to disc sata_sil driver hangs.
> Nothing ooops or something like this only following messages:
> ata1: DMA timeout, stat 0x4
> ata2: DMA timeout, stat 0x4
>   I tried add this discs to sil_blacklist with SIL_QUIRK_MOD15WRITE,
> tried your try4 patch and nothing helps.
>   Any ideas?
  2.6.7 with [PATCH] fix sata_sil quirk and blacklisted Seagate seems working.
hdparm says only 13 MB/sec :( but it WORKS. Any chance for working in 2.4
or should i buy old&good Maxtor instead :-) ?

  Have a nice day,
Dave
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
