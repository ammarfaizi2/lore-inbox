Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWAOBuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWAOBuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 20:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWAOBuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 20:50:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18363
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750847AbWAOBuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 20:50:05 -0500
Date: Sat, 14 Jan 2006 17:46:59 -0800 (PST)
Message-Id: <20060114.174659.16358136.davem@davemloft.net>
To: pavel@ucw.cz
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060112010406.GA2367@ucw.cz>
References: <43C42F0C.10008@redhat.com>
	<20060111.000020.25886635.davem@davemloft.net>
	<20060112010406.GA2367@ucw.cz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 12 Jan 2006 01:04:06 +0000

> Could you possibly 
> #define IP_OFFSET htons(1234)
> ?
> 
> Noone should need it in native endianity, no?

That's definitely going to be error prone.
And I bet the BSD headers define it in cpu endainness
as well.
