Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263306AbVGOO0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbVGOO0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbVGOO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:26:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:15839 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263306AbVGOO0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:26:48 -0400
Subject: Re: console remains blanked
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050714101807.74323.qmail@web25805.mail.ukl.yahoo.com>
References: <20050714101807.74323.qmail@web25805.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 00:26:46 +1000
Message-Id: <1121437606.5963.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I have this problem since 2.6.12-rc2.
> If I add back the patch hunk specified in my original
> message, the blanking behaviour changes to that
> present in pre-2.6.12-rc2 kernels.

And you'll have nice scheduling in atomic for any printk() done in
atomic context that triggers the unblank() when using radeonfb on an
LVDS LCD panel...
 
> I just would like to know if this new behaviour is
> just intentional and makes sense to everyone (except
> me :-)



