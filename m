Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUKOEbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUKOEbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKOEbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:31:04 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:25485 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261410AbUKOEbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:31:00 -0500
Message-ID: <419830FD.7000007@yahoo.com.au>
Date: Mon, 15 Nov 2004 15:30:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalize prio_tree (1/3)
References: <20041114235646.K28802@almesberger.net>
In-Reply-To: <20041114235646.K28802@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Hi Rajesh,
> 
> perhaps you remember me posting a long time ago about generalizing
> prio_tree. Now I finally got to make that patch. In fact, there are
> three parts:
> 
>  - the prio_tree "core" in lib/
>  - switching mm/prio_tree.c to use the "core"
>  - some debugging extensions
> 
> The reason for wanting this generalization is that we'll also need
> radix priority search trees for healthier barrier handling in the
> IO scheduler (aka disk elevator).
> 

I'm curious, how do you plan to use them for healthier barrier handling?

