Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWAWPL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWAWPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWAWPL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:11:57 -0500
Received: from mail.suse.de ([195.135.220.2]:3247 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751466AbWAWPL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:11:56 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
Date: Mon, 23 Jan 2006 16:11:51 +0100
User-Agent: KMail/1.8
Cc: pravin shelar <pravins@calsoftinc.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <200601231224.16196.ak@suse.de> <43D4DA15.4010009@cosmosbay.com>
In-Reply-To: <43D4DA15.4010009@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601231611.51326.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 14:28, Eric Dumazet wrote:

> Shouldnt we force a page fault for not possible cpus in cpu_data
> to catch all access to per_cpu(some_object, some_not_possible_cpu) ?
>
> We can use a red zone big enough to hold the whole per_cpu data.

Good idea. Can you please send me a tested patch?

-Andi
