Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVLEGNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVLEGNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 01:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVLEGNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 01:13:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:34534 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751324AbVLEGNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 01:13:10 -0500
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: Michael Buesch <mbuesch@freenet.de>, Feyd <feyd@seznam.cz>,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
In-Reply-To: <20051205055012.GE8953@jm.kir.nu>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	 <20051204205208.46e44480@epsilon.site>
	 <200512042058.30801.mbuesch@freenet.de>  <20051205055012.GE8953@jm.kir.nu>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 17:05:34 +1100
Message-Id: <1133762735.6100.137.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wouldn't it be better to try to get that functionality added into the
> net/ieee80211 code instead of maintaining separate extension outside the
> kernel tree? Many modern cards need the ability for the host CPU to take
> care of management frame sending and receiving and from my view point,
> this code should be in net/ieee80211. Many (all?) of the functions in
> this "SoftMAC" look like something that would be nice to have as an
> option in net/ieee80211. In other words, the low-level driver would
> indicate what kind of functionality it needs and ieee80211 stack would
> behave differently based on the underlying hardware profile.

It would certainly be a good idea and I'm sure that's what will happen
once the code is mature enough ;)

Ben.


