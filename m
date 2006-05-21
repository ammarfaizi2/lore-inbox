Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWEURNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWEURNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWEURNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 13:13:15 -0400
Received: from canuck.infradead.org ([205.233.218.70]:59108 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751548AbWEURNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 13:13:15 -0400
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
From: David Woodhouse <dwmw2@infradead.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060520141011.GJ7570@earth.li>
References: <20060518160940.GS7570@earth.li>
	 <20060520141011.GJ7570@earth.li>
Content-Type: text/plain
Date: Sun, 21 May 2006 18:12:58 +0100
Message-Id: <1148231578.12285.5.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-20 at 15:10 +0100, Jonathan McDowell wrote:
> Ok, taking the comments on board let's try again.
> 
>  * Use ndelay(40) instead of udelay(0.04). This will involve a longer
>    delay, but works fine and will take advantage of ndelay once ARM
>    stops using the generic fallback.
>  * Fixup errant spacing.
>  * Make ams_delta_init static.

Applied; thanks.

-- 
dwmw2

