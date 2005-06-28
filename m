Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVF1MUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVF1MUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVF1MUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:20:53 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:54946 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261442AbVF1MUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:20:47 -0400
Message-ID: <42C1409B.8000305@yahoo.com.au>
Date: Tue, 28 Jun 2005 22:20:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Kearster <david.kearster@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] lockless pagecache
References: <3bba6cc4050628045676c61112@mail.gmail.com>
In-Reply-To: <3bba6cc4050628045676c61112@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Kearster wrote:
> Hi nick,
> 
> The patches that u posted on lkml regarding the vfs scalibility, on
> which kernel did u build them.
> I tried applying them on 2.6.12-git4, 2.6.12-mm1, mm2, 2.6.12.1, but
> to no avail.
> 

Hi David,

They are against 2.6.12-git4 plus a later revision of the PageRemoval
patchset I posted to linux-mm earlier, which is needed to make page
refcounting consistent.

I have a couple of updates and fixes for both sets of patches, so I
can send you a rollup of the current patches against a current -git
kernel privately if you would like.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
