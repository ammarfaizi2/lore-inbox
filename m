Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUFZVZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUFZVZh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUFZVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:25:36 -0400
Received: from mail.njit.edu ([128.235.251.173]:64688 "EHLO mail-gw5.njit.edu")
	by vger.kernel.org with ESMTP id S266436AbUFZVZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:25:35 -0400
Date: Sat, 26 Jun 2004 17:25:34 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: TCP_SKB_CB question
Message-ID: <Pine.GSO.4.58.0406261710060.13358@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to modify the file ip_input.c. I created a new function of my
own in that file. This function has the following declaration

int switch_check(struct sk_buff *skb)

Within this function I am trying to read the ack value as follows

__u32 ack_value = TCP_SKB_CB(skb)->ack_seq;

However I am getting the following compile errors when I try to recompile
the kernel.

warning: implicit declaration of function TCP_SKB_CB
error: invalid type arguement of ->

Can someone point me where I went wrong.

Thanks,
Rahul.
