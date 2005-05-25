Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVEYU7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVEYU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVEYU7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:59:16 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:35274 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261564AbVEYU7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:59:14 -0400
Date: Wed, 25 May 2005 16:58:41 -0400
From: Tom Vier <tmv@comcast.net>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525205841.GB28913@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116890066.13086.61.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If irqs are run in threads, which are scheduled, how are they scheduled?
fifo? What's the point then; simply to let the top half run to completion
before another top half starts? If it's about setting scheduling priorities
for irq threads, some one top half can prempt another, why not just use irq
levels, like bsd (using pic's is slower than using threads?)?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
