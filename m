Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVHRVdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVHRVdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHRVdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:33:44 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:52122
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S932465AbVHRVdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:33:43 -0400
Date: Thu, 18 Aug 2005 14:32:48 -0700 (PDT)
Message-Id: <20050818.143248.58283961.davem@davemloft.net>
To: cw@f00f.org
Cc: Sebastian.Classen@freenet-ag.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: overflows in /proc/net/dev
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050818163358.GA19554@taniwha.stupidest.org>
References: <1124350090.29902.8.camel@basti79.freenet-ag.de>
	<20050818163358.GA19554@taniwha.stupidest.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wedgwood <cw@f00f.org>
Date: Thu, 18 Aug 2005 09:33:58 -0700

> I thought the concensurs here was that because doing reliable atomic
> updates of 64-bit values isn't possible on some (most?) 32-bit
> architectures so we need additional locking to make this work which is
> undesirable?  (It might even be a FAQ by now as this comes up fairly
> often).

That's correct.
