Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279630AbRKIHVu>; Fri, 9 Nov 2001 02:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKIHVk>; Fri, 9 Nov 2001 02:21:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:5386 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279598AbRKIHV3>; Fri, 9 Nov 2001 02:21:29 -0500
Message-ID: <3BEB82B8.541558CA@zip.com.au>
Date: Thu, 08 Nov 2001 23:16:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ak@suse.de, anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <3BEB7DA6.BC8793B1@zip.com.au>,
		<20011108.220444.95062095.davem@redhat.com>
		<20011109073946.A19373@wotan.suse.de>
		<3BEB7DA6.BC8793B1@zip.com.au> <20011108.231717.85686073.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Thu, 08 Nov 2001 22:54:30 -0800
> 
>    I played with that earlier in the year.  Shrinking the hash table
>    by a factor of eight made no measurable difference to anything on
>    a Pentium II.  The hash distribution was all over the place though.
>    Lots of buckets with 1-2 pages, lots with 12-13.
> 
> What is the distribution when you don't shrink the hash
> table?
> 

Well on my setup, there are more hash buckets than there are
pages in the system.  So - basically empty.  If memory serves
me, never more than two pages in a bucket.
