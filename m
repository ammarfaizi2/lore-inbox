Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUIIUhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUIIUhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUIIUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:37:39 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:33343 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S265973AbUIIUhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:37:36 -0400
Message-ID: <4140BF03.9050801@pantasys.com>
Date: Thu, 09 Sep 2004 13:37:23 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Noll <noll@mathematik.tu-darmstadt.de>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Obvious compile fix for net/ipv4/ipconfig.c
References: <20040909193613.GD22045@p133>
In-Reply-To: <20040909193613.GD22045@p133>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2004 20:30:43.0203 (UTC) FILETIME=[E1059530:01C496AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Noll wrote:
> The undeclared variable in ic_bootp_recv was introduced by Peter's
> previous IPCONFIG patch (Logical change 1.21935).

I fixed this by changing the for loop to a memcmp(), I think that this 
conveys the intention of the code more clearly. David already accepted 
that patch and it should be making it's way upstream as we speak.

peter
