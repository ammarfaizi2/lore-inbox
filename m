Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUFHDFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUFHDFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 23:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUFHDFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 23:05:39 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:62801 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265163AbUFHDFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 23:05:39 -0400
Message-ID: <40C52CFF.4080207@yahoo.com.au>
Date: Tue, 08 Jun 2004 13:05:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Phy Prabab <phyprabab@yahoo.com>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, wli@holomorphy.com
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <200406080712.44759.kernel@kolivas.org>	<20040607214034.27475.qmail@web51807.mail.yahoo.com> <20040607195011.34f8e84e.akpm@osdl.org>
In-Reply-To: <20040607195011.34f8e84e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> At a guess I'd say either a) you're hitting some path in the kernel which
> is going for a giant and bogus romp through memory, trashing CPU caches or
> b) your workload really dislikes run-child-first-after-fork or c) the page
> allocator is serving up pages which your access pattern dislikes or d)
> something else.
> 

e) it's the staircase scheduler patch?
