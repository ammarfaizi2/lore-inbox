Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWHJABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWHJABf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWHJABd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:01:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58500
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751375AbWHJABc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:01:32 -0400
Date: Wed, 09 Aug 2006 17:01:18 -0700 (PDT)
Message-Id: <20060809.170118.116356057.davem@davemloft.net>
To: a.p.zijlstra@chello.nl
Cc: tgraf@suug.ch, phillips@google.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <1155140394.12225.88.camel@twins>
References: <1155132440.12225.70.camel@twins>
	<20060809161816.GA14627@postel.suug.ch>
	<1155140394.12225.88.camel@twins>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Wed, 09 Aug 2006 18:19:54 +0200

> disregards this part from -v2 then :-(

And please don't do arbitrary cleanups in your patches like
how you reformatted all of the NETIF_F_* macro values.

Do things like that as a seperate change in your set of
patches so it's easier for people to review your work.
