Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWJASLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWJASLH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWJASLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:11:07 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:26861 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932153AbWJASLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:11:04 -0400
Date: Sun, 1 Oct 2006 20:08:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: kkeil@suse.de, kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: mark as 32-bit only
In-Reply-To: <20061001152116.GA4684@havoc.gtf.org>
Message-ID: <Pine.LNX.4.61.0610012007240.13920@yvahk01.tjqt.qr>
References: <20061001152116.GA4684@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Tons of ISDN drivers cast pointers to/from 32-bit values, which just
>won't work on 64-bit.

Should not that be fixed instead of restricting isdn to 32bit?
Though this is probably the best temporary workaround until someone can 
fix up all the "tons".


Jan Engelhardt
-- 
