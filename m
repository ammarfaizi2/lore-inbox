Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbTCJRlx>; Mon, 10 Mar 2003 12:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbTCJRlx>; Mon, 10 Mar 2003 12:41:53 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:19347 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261380AbTCJRlw>; Mon, 10 Mar 2003 12:41:52 -0500
Date: Mon, 10 Mar 2003 18:52:21 +0100
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: Dcache hash distrubition patches
Message-ID: <20030310175221.GA20060@averell>
References: <10280000.1047318333@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10280000.1047318333@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Conclusion: the hash distribution (for this simple test) looks fine
> to me.

Yes, because of the overkill size of the hash table. With a 100K + entry
table you can make near every hash function look good ;)

Try to reduce it to a smaller number of buckets and see what happens.

-Andi



