Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUAQXpV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUAQXpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:45:21 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:20147 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266237AbUAQXpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:45:15 -0500
Subject: Re: [RFC] kill sleep_on
From: David Woodhouse <dwmw2@infradead.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1074383111.9965.4.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sat, 17 Jan 2004 23:45:11 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-17 at 20:10 +0000,
viro@parcelfarce.linux.theplanet.co.uk wrote:
> AFAICS, _all_ uses of sleep_on() in drivers are broken in one way or another
> and BKL won't help them.

I think ext3 and nfs get away with it at the moment by using the BKL. It
does want fixing though.

-- 
dwmw2


