Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUGBS4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUGBS4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUGBS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:56:51 -0400
Received: from mail-gw4.njit.edu ([128.235.251.32]:19876 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S264795AbUGBS4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:56:49 -0400
Date: Fri, 2 Jul 2004 14:56:48 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: Question about ip_rcv_finish()
Message-ID: <Pine.GSO.4.58.0407021451250.8213@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I had a questions regarding a piece of code in ip_rcv_finish() function.
This function checks if there are any options in the packet. If so, it
only tries to process the Strict Source Route option.

if (opt->srr) {
	....
	if (ip_options_rcv_srr(skb))
		goto drop;
}

Can anyone please explain, why only opt->srr is being checked for and not
the other two options namely opt->rr and opt->ts.

Thanks,
Rahul.
