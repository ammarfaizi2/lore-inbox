Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUJZTFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUJZTFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUJZTFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:05:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:63397 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261419AbUJZTE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:04:59 -0400
Date: Tue, 26 Oct 2004 21:13:19 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Would auto setting CONFIG_RTC make sense when building SMP kernel?
Message-ID: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've been wondering if it would make sense to auto enable CONFIG_RTC when 
CONFIG_SMP is set?

I'm judging entirely from this bit of text from the CONFIG_RTC help text : 

[...]
If you run Linux on a multiprocessor machine and said Y to
"Symmetric Multi Processing" above, you should say Y here to read
and set the RTC in an SMP compatible fashion.
[...]

Isn't it always desirable to be able to set the clock in an SMP compatible 
fashion if the kernel is indeed build for SMP?

If it would make sense to make such a change I'll be happy to supply a 
patch.

--
Jesper Juhl


