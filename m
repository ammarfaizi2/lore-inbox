Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWH1Qjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWH1Qjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWH1Qjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:39:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65408 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750801AbWH1Qjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:39:52 -0400
Subject: Re: Serial custom speed deprecated?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608281047360.388@chaos.analogic.com>
References: <20060826181639.6545.qmail@science.horizon.com>
	 <Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com>
	 <1156775994.6271.28.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0608281047360.388@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Aug 2006 18:01:34 +0100
Message-Id: <1156784494.6271.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 10:50 -0400, ysgrifennodd linux-os (Dick Johnson):
> It has nothing to do with 'personal laws of physics'. On all recent
> implementations, B0 is 0, i.e., the absence of any bits set. Therefore,
> there is no observable difference between CBAUDEX and CBAUDEX | B0,
> as shown above. 

Correct

> Therefore, as I stated, it won't work.

Incorrect


The state

	(flag & CBAUD) == (CBAUDEX|0)

is not currently used

CBAUDEX|1 .. CBAUDX|15 are used as are 0-15.


