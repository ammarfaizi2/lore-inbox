Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWESKtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWESKtR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWESKtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:49:17 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33979 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932258AbWESKtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:49:17 -0400
Date: Fri, 19 May 2006 12:49:12 +0200
From: Sander <sander@humilis.net>
To: Michael Robak <mrobak@Omneon.com>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Message-ID: <20060519104912.GA16598@favonius>
Reply-To: sander@humilis.net
References: <F0E8D0B1F8999D479196DA72521D954A8DA9FF@snv-exh1.omneon.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0E8D0B1F8999D479196DA72521D954A8DA9FF@snv-exh1.omneon.local>
X-Uptime: 12:41:50 up 11 days,  3:30, 30 users,  load average: 1.12, 1.98, 2.19
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Robak wrote (ao):
> It apears that having multiple bus speeds is not the cause of my issue.
> I was able to get the sata_mv module initalization to hang even when I
> had only 2 cards plugged into both of the 100 MHz slots. This issue is
> extremely difficult to diagnose. Sometimes the sata_mv module will load
> just fine and recognize 24 drives, others it will hang the system during
> intalization, and others it will only fine 23 drives, but the
> initalization completes.
> 
> Any help would be appreciated,

I'm affraid I can't help you much. Mark Lord works on getting the driver
stable on 2.6.16.x kernels. After that he wants to port forward the
changes.

FWIW, there is quite a big libata update which I assume goes into
2.6.17-rc4-mm2. Maybe that helps?

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
