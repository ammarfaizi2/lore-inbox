Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbUBXERd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUBXERd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:17:33 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:49874 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262152AbUBXERc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:17:32 -0500
Message-ID: <403ACEFC.4070208@cyberone.com.au>
Date: Tue, 24 Feb 2004 15:11:40 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
References: <20040222172200.1d6bdfae.akpm@osdl.org> <40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au> <40396DA7.70200@cyberone.com.au> <4039B4E6.3050801@cyberone.com.au> <4039BE41.1000804@cyberone.com.au> <20040223005948.10a3b325.akpm@osdl.org> <20040223224723.GA27639@dingdong.cryptoapps.com>
In-Reply-To: <20040223224723.GA27639@dingdong.cryptoapps.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Wedgwood wrote:

>On Mon, Feb 23, 2004 at 12:59:48AM -0800, Andrew Morton wrote:
>
>
>>We've never clearly defined whether pages_high == free_pages means
>>the zone is under limits.  According to __alloc_pages() it means
>>that the zone is not under limits, so you've fixed two bugs there.
>>
>
>FWIW 2.6.3-mm3 with the above fix right now seems to behave much
>better in my non-contrived cases than previous kernels I've tested
>with.
>

Out of interest, what is the worst you can make it do with
contrived cases?

