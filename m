Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWALBod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWALBod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWALBod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:44:33 -0500
Received: from canuck.infradead.org ([205.233.218.70]:28291 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964964AbWALBoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:44:32 -0500
Subject: Re: PPC build broken (last two days)
From: David Woodhouse <dwmw2@infradead.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1137027982.2890.99.camel@cog.beaverton.ibm.com>
References: <1137027982.2890.99.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 01:44:15 +0000
Message-Id: <1137030255.4196.194.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 17:06 -0800, john stultz wrote:
>         I've been getting the following compile error w/ Linus' git
> tree for the last two days:

Use ARCH=powerpc for pmac builds. I believe the plan is to drop
chrp/prep/pmac support from the legacy arch/ppc and leave it for the
embedded platforms alone.

-- 
dwmw2

