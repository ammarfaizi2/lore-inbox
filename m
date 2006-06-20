Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWFTO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWFTO6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFTO6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:58:22 -0400
Received: from mail.parknet.jp ([210.171.160.80]:25862 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751263AbWFTO6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:58:22 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Jean-Daniel Pauget <jd@disjunkt.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, george@mvista.com
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
References: <20060620100800.GB5040@disjunkt.com>
	<20060620101946.GA32658@rhlx01.fht-esslingen.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 20 Jun 2006 23:58:01 +0900
In-Reply-To: <20060620101946.GA32658@rhlx01.fht-esslingen.de> (Andreas Mohr's message of "Tue, 20 Jun 2006 12:19:46 +0200")
Message-ID: <87zmg7q3gm.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:

>>     but now, how and to whom should I report ?
>
> We need to enhance current kernel to whitelist this chipset revision
> somehow. Or at least put a note there that this revision is ok, too
> (to wait some more time for further evidence/revisions to appear).

Almost ICH4 should be sane.  Since there seems both reports of good
and bad, probably the bug of ICH4 seems to be depending on a specific
motherboard.

FWIW, If you want to reduce gray-list, probably it should be
motherboard list.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
