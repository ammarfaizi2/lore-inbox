Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWEaHKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWEaHKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 03:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWEaHKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 03:10:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15503
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S964854AbWEaHKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 03:10:07 -0400
Date: Wed, 31 May 2006 00:10:27 -0700 (PDT)
Message-Id: <20060531.001027.60486156.davem@davemloft.net>
To: bidulock@openss7.org
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060530235525.A30563@openss7.org>
References: <20060531042908.10463.qmail@web51410.mail.yahoo.com>
	<20060530235525.A30563@openss7.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Brian F. G. Bidulock" <bidulock@openss7.org>
Date: Tue, 30 May 2006 23:55:26 -0600

> For example, it goes to great pains to permute upper order bits in
> the local address, which for most connections will be a constant
> value.

Consider an apache server hosting thousands of virtual
hosts.  The local address will be different for every
such host.

Please drop linux-kernel in any future replies, this
discussion belongs on netdev not linux-kernel.  Thanks.
