Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVHSHtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVHSHtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHSHtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:49:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29966 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964899AbVHSHtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:49:15 -0400
Date: Fri, 19 Aug 2005 08:49:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
Message-ID: <20050819084911.A1154@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk> <42D81AD7.3000407@drzeus.cx> <20050718184554.A31022@flint.arm.linux.org.uk> <42F74425.90908@drzeus.cx> <20050819000903.B11254@flint.arm.linux.org.uk> <430578C3.7020406@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <430578C3.7020406@drzeus.cx>; from drzeus-list@drzeus.cx on Fri, Aug 19, 2005 at 08:14:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 08:14:27AM +0200, Pierre Ossman wrote:
> * Things that assume there's a name for every kobject.

The name is assigned when the host is added to the mmc subsystem,
not when it's allocated.  This is the same behaviour as other
subsystems (eg, networking) and I don't see a problem with that.

> * Things that assume that a kobject's name cannot change.

The mmc host name will never change once its initially set.

> Otherwise I'm just waiting to see this committed.

Post 2.6.13, probably at akpm's discression.  As I mentioned in other
mails, I will be away from kernel work next week, which is probably
when 2.6.13 will be released.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
