Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUJAQVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUJAQVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJAQRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:17:53 -0400
Received: from mail-gw5.njit.edu ([128.235.251.173]:38075 "EHLO
	mail-gw5.njit.edu") by vger.kernel.org with ESMTP id S264386AbUJAQRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:17:07 -0400
Date: Fri, 1 Oct 2004 12:17:03 -0400 (EDT)
From: Rahul Jain <rbj2@oak.njit.edu>
To: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Difference between Header Cache and Neighbour
Message-ID: <Pine.GSO.4.58.0410011210430.8468@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am not able to figure out what is the difference between the Header
Cache and the Neighbour structure.

The function I am looking into is ip_finish_output2() (ip_output.c). In
that function the kernel is checking whether the dst_entry for a skb
contains 'hh' or 'neighbour'. It then calls the output function of one of
them.

What I am confused about is that, when going through the code, I found
that hh->output and neighbour->output, both point to dev_queue_xmit. Is
this correct ? And if so, then what is the difference between dst->hh and
dst->neighbour.

I would appreciate your advice and comments

Thanks,
Rahul.
