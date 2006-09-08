Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWIHG7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWIHG7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 02:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWIHG7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 02:59:08 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:50362 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751812AbWIHG7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 02:59:04 -0400
Date: Fri, 8 Sep 2006 08:58:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Oleg Verych <olecom@flower.upol.cz>
cc: linux-kernel@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: re-reading the partition table on a "busy" drive
In-Reply-To: <450105C0.2010603@flower.upol.cz>
Message-ID: <Pine.LNX.4.61.0609080857090.30219@yvahk01.tjqt.qr>
References: <45004707.4030703@tls.msk.ru> <450105C0.2010603@flower.upol.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
> Yes, very interesting thing. While one will destroy its part.table, he can not
> see until reboot, heh. But there were days, when grub used to install itself on
> XFS partition (XFS isn't FAT-boot-record compatible) *silently*, but nothing
> was wrong to me : it's linux-gnu ;D

People running XFS should know you cannot put boot code into the PBR.



Jan Engelhardt
-- 
