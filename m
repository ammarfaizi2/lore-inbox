Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262944AbTCKPNB>; Tue, 11 Mar 2003 10:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbTCKPNB>; Tue, 11 Mar 2003 10:13:01 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:33668 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262944AbTCKPM7>; Tue, 11 Mar 2003 10:12:59 -0500
Date: Tue, 11 Mar 2003 16:23:22 +0100
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dcache hash distrubition patches
Message-ID: <20030311152322.GA2358@averell>
References: <10280000.1047318333@[10.10.2.4]> <20030310175221.GA20060@averell> <26350000.1047368465@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26350000.1047368465@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 08:41:07AM +0100, Martin J. Bligh wrote:
> some numbers. They still look pretty good to me. I shrunk us from
> 1,048,576 buckets to 65536, and loaded 1,150,000 entries in there.

Interesting would be to find the sweet spot with the smallest hash table 
size that still performs well. Not sure if find / is a good workload
for that though.

Also same for inode hash (but I don't have statistics for that right now)

-Andi
