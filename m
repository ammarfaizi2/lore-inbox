Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbUJ1NWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUJ1NWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUJ1NWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:22:23 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:37647 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263057AbUJ1NWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:22:17 -0400
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net> <873bzzw60c.fsf@devron.myhome.or.jp>
	<200410280714.40033.gene.heskett@verizon.net>
	<200410280812.41150.gene.heskett@verizon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 28 Oct 2004 22:21:07 +0900
In-Reply-To: <200410280812.41150.gene.heskett@verizon.net> (Gene Heskett's
 message of "Thu, 28 Oct 2004 08:12:41 -0400")
Message-ID: <87oeingerg.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> After the reboot to a 2.6.10-rc1-bk6 plus your patch, its still fine, 
> and except for the usual references to /dev/sda1 in the log when I 
> turn it on or off, mounting it and scanning its directory doesn't 
> generate any additional log info.  Was it supposed to?

This bug is triggered by race condition. So, it may not happen.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
