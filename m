Return-Path: <linux-kernel-owner+w=401wt.eu-S1755243AbXABDgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbXABDgb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbXABDgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:36:31 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46589
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755243AbXABDgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:36:31 -0500
Date: Mon, 01 Jan 2007 19:36:24 -0800 (PST)
Message-Id: <20070101.193624.104645809.davem@davemloft.net>
To: dmk@flex.com
Cc: segher@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <4599B809.1000300@flex.com>
References: <385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org>
	<20070101.150831.17863014.davem@davemloft.net>
	<4599B809.1000300@flex.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Kahn <dmk@flex.com>
Date: Mon, 01 Jan 2007 17:40:25 -0800

> If that doesn't fit the model of /sys or /proc,
> I suppose it could be done in a separate file
> system, but that's overkill, isn't it?

Or by a device driver, which is what OFW systems have
been doing for years, and we have it already, it's called
/dev/openprom and if you provide the of_*() API you could
use it out of the box too.
