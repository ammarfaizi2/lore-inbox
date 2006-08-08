Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWHHXHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWHHXHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWHHXHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:07:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45967 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932237AbWHHXHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:07:14 -0400
Message-ID: <44D9191E.7080203@garzik.org>
Date: Tue, 08 Aug 2006 19:07:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193447.1396.59301.sendpatchset@lappy>
In-Reply-To: <20060808193447.1396.59301.sendpatchset@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Update the driver to make use of the netdev_alloc_skb() API and the
> NETIF_F_MEMALLOC feature.

NETIF_F_MEMALLOC does not exist in the upstream tree...  nor should it, IMO.

netdev_alloc_skb() is in the tree, and that's fine.

	Jeff



