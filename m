Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTI0D0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 23:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTI0D0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 23:26:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1938 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262041AbTI0D0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 23:26:15 -0400
Date: Fri, 26 Sep 2003 20:12:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030926201239.2a2f0ef0.davem@redhat.com>
In-Reply-To: <20030926183827.A821@jurassic.park.msu.ru>
References: <3F73D9C4.1050201@colorfullife.com>
	<20030925230702.4ef87780.davem@redhat.com>
	<20030926183827.A821@jurassic.park.msu.ru>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 18:38:27 +0400
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> What about aligning the packet directly in the rx buffer (by memmoving
> the entire packet to buf+2) instead of copying to another skb?
> This appears to be a) more than 2 times faster b) easy to implement.

That's another possibility.
