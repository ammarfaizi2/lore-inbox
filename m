Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUFYPLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUFYPLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266754AbUFYPLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:11:20 -0400
Received: from mail.njit.edu ([128.235.251.173]:5030 "EHLO mail-gw5.njit.edu")
	by vger.kernel.org with ESMTP id S266753AbUFYPLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:11:19 -0400
Date: Fri, 25 Jun 2004 11:11:17 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: sk_buff understanding
Message-ID: <Pine.GSO.4.58.0406251109510.6693@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just want to know if my understanding of how the sk_buff structure
works is correct.

When data arrives at the TCP layer it is pointed to by the data pointer
and the TCP header goes in the skb->data-skb->head area. When this packet
is passed to the IP layer, skb->tail-skb->data section will now contain
the TCP header + TCP data and now the IP header will be put in the new
skb->data-skb->head area.

Please let me know if this understanding is correct.

I also wanted to know does psk_may_pull() only check for correct header
length or does it (thought some func calls) strip off the IP header ?

Thanks,
Rahul.

