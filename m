Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUHWAQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUHWAQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 20:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUHWAQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 20:16:51 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:40082 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267168AbUHWAQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 20:16:50 -0400
Message-ID: <4129376D.3050006@yahoo.com.au>
Date: Mon, 23 Aug 2004 10:16:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fix PID hash sizing
References: <412824BE.4040801@yahoo.com.au> <20040822123224.GC1510@holomorphy.com>
In-Reply-To: <20040822123224.GC1510@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Sun, Aug 22, 2004 at 02:44:46PM +1000, Nick Piggin wrote:
>
>>I see PID hash sizing problems on an Opteron.
>>I thought this got fixed a while ago? Hm.
>>Export nr_kernel_pages, nr_all_pages. Use nr_kernel_pages when sizing
>>the PID hash. This fixes a sizing problem I'm seeing with the x86-64 kernel
>>on an Opteron.
>>
>
>Please describe the the pid hash sizing problem.
>
>
>

max_pfn isn't set up at that time yet, I'm guessing. I didn't look
into it further than that.

