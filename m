Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWG0U4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWG0U4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWG0U4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:56:06 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:2320 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751072AbWG0Uzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:55:37 -0400
Date: Thu, 27 Jul 2006 22:55:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
Message-Id: <20060727225549.40b14655.khali@linux-fr.org>
In-Reply-To: <m34pxoh0pd.fsf@defiant.localdomain>
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain>
	<44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain>
	<44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain>
	<44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain>
	<44B248E4.2020506@pol.net>
	<m3u05p4mkx.fsf@defiant.localdomain>
	<44B26004.4050500@gmail.com>
	<m3r70tqxmt.fsf@defiant.localdomain>
	<44B2808F.8000901@pol.net>
	<m3ac7h6vxy.fsf@defiant.localdomain>
	<44B351CF.1090001@pol.net>
	<m34pxoh0pd.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > X has its own i2c functionality which is completely separate from the
> > kernel i2c layer.
> 
> Yes, but X11 could use I2C adapter functionality provided by the
> kernel.

Yes, it should. Now, go convince the X folks to do so...

In practice, I would guess that both X and the framebuffer drivers only
use the I2C/DDC channel to read the monitor's EDID at initialization
time, so the risk of concurrent accesses is thin.

Good luck,
-- 
Jean Delvare
