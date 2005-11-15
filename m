Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVKOFjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKOFjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKOFjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:39:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37521
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751294AbVKOFjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:39:14 -0500
Date: Mon, 14 Nov 2005 21:39:22 -0800 (PST)
Message-Id: <20051114.213922.16377460.davem@davemloft.net>
To: mpm@selenic.com
Cc: jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [BUG] netpoll is unable to handle skb's using packet split
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051115052358.GG31287@waste.org>
References: <9929d2390511141315t2fb15b2aucbbebcbe4cec7ef1@mail.gmail.com>
	<20051115052358.GG31287@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Mon, 14 Nov 2005 21:23:58 -0800

> What is "packet split" in this context?

It's a mode of buffering used by the e1000 driver.
