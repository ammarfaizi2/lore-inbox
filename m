Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVI3SSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVI3SSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVI3SSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:18:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64266 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932567AbVI3SSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:18:08 -0400
Date: Fri, 30 Sep 2005 19:18:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: Josh Boyer <jdub@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
       dwmw2@infradead.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [patch] switch mtd to new driver model & cleanups
Message-ID: <20050930181801.GA31152@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@ru.mvista.com>,
	Josh Boyer <jdub@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
	dwmw2@infradead.org, kernel list <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
References: <20050930121741.GA5506@elf.ucw.cz> <433D482A.1000708@ru.mvista.com> <1128089827.3111.2.camel@windu.rchland.ibm.com> <433D8010.1090701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433D8010.1090701@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 10:12:32PM +0400, Vitaly Wool wrote:
> As far as I've heard, there's gonna be a megre quite soon... :)
> Anyway, I guess it'd be better if Pavel ntroduced the new patch against 
> the latest linux-mtd code.

I don't think it's required.  The SA1100 map driver handles the PM
already, as I'm sure the PXA map driver will also.

All it takes is for the other map drivers to be converted and hey
presto, the MTD subsystem has power management support done the
right way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
