Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTD3N5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTD3N5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:57:47 -0400
Received: from post2.inre.asu.edu ([129.219.110.73]:54256 "EHLO
	post2.inre.asu.edu") by vger.kernel.org with ESMTP id S262179AbTD3N5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:57:46 -0400
Date: Wed, 30 Apr 2003 07:10:04 -0700 (MST)
From: Shesha@asu.edu
Subject: Why throughput increases as MTU size is increased
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Message-id: <Pine.GSO.4.21.0304300706400.28571-100000@general2.asu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
 I have a question which I am not able to answer myself.I request you all to
give
me some input.
 When I measure the performance of iSCSI on XScale with MTU size = 1500 bytes,
a throughput of 32 Mbps was observed. As the MTU size was increased, the
throughput also increased.
1500 -> 32 Mbps
3000 -> 56
4500 -> 80
6000 -> 100
7500 -> 108
9000 -> 108

Actually the throughput saturates. I thought, the per-packet overhead
decreases as the MTU
size increases. This contributes to the performance improvement. And the
saturation is achieved because, the iSCSI max PDU size is 8k. Even if
we increase the MTU size beyond 8k, we will not see any change because,
iSCSI
devivers a max of 8K PDU to TCP. Therefore a saturation in throughput is
observed.

But  the question is, Am I thinking correctly?
secondly, if yes,does the per-packet over head decrease the performance so
much. we are observing, somewhere like 4 times improvement in throughput. Can
there be any other reason for this observation. 

Thanking you 
Shesha




