Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbTH1I5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTH1I4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:56:13 -0400
Received: from ferengi.skynet.be ([195.238.2.126]:16615 "EHLO
	ferengi.skynet.be") by vger.kernel.org with ESMTP id S263944AbTH1IzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:55:12 -0400
Message-Id: <200308280850.h7S8oxGx001862@pc.skynet.be>
From: Hans Lambrechts <hans.lambrechts@skynet.be>
Subject: Re: Linux 2.4.23-pre1
To: linux-kernel@vger.kernel.org
Date: Thu, 28 Aug 2003 10:50:58 +0200
References: <pcKD.6BP.19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

> Harald Welte:
>   o [NETFILTER]: Backport iptables AH/ESP fixes from 2.6.x
>   o [NETFILTER]: Fix uninitialized return in iptables tftp
>   o [NETFILTER]: NAT optimization
>   o [NETFILTER]: Conntrack optimization (LIST_DELETE)
> 


I see this in my log:

Aug 28 10:45:44 pc kernel: MASQUERADE: No route: Rusty's brain broke!
Aug 28 10:46:10 pc last message repeated 13 times
Aug 28 10:48:42 pc kernel: NET: 1 messages suppressed.
Aug 28 10:48:42 pc kernel: MASQUERADE: No route: Rusty's brain broke!
Aug 28 10:48:43 pc kernel: MASQUERADE: Route sent us somewhere else.

Forwarding and masquerading doesn't work anymore.

Hans
