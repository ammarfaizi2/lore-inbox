Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936961AbWLDPFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936961AbWLDPFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936957AbWLDPFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:05:00 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:27364 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S936921AbWLDPE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:04:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KWNnKcN9wF0bUcIebsInj/CMUvkuCTf18FLddFUN6ILEvzstcrMDpnehQW4IZJbKf9LmC/S8l8rWp3dcD9GqxnA9YunXPe+iLjz/LDgeYAS0SaikFPe8+dDWCJd3eqlJvBIYD+Y8dTk0lawTF2q6cr0ENYcy5Blv15ttgU2koPU=  ;
X-YMail-OSG: ULIs1bEVM1ntOwaJpj2Dnp.fQFA2g9sh2p48zelwG.Aq9.6aTZe9YqjLunbQ45zfR7E3ofMxsDmmDdlRBEmanoDrGdlsY_3Zuc8i9LVlYYRniHqMVo3HcjHLMw1KQvRlanxJ1b4.Wo4IW0s-
Message-ID: <457438E9.1010503@yahoo.com.au>
Date: Tue, 05 Dec 2006 02:04:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aucoin@Houston.RR.com
CC: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612041445.kB4EjaGi009655@ms-smtp-05.texas.rr.com>
In-Reply-To: <200612041445.kB4EjaGi009655@ms-smtp-05.texas.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin wrote:
>>From: Nick Piggin [mailto:nickpiggin@yahoo.com.au]
>>We had customers see similar incorrect OOM problems, so I sent in some
>>patches merged after 2.6.16. Can you upgrade to latest kernel? (otherwise
>>I guess backporting could be an option for you).
> 
> 
> I will raise the question of moving the kernel forward one more time before
> release. Can you point me to the patches you mentioned?

These two are the main ones:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=408d85441cd5a9bd6bc851d677a10c605ed8db5f
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4ff1ffb4870b007b86f21e5f27eeb11498c4c077

They shouldn't be too hard to backport.

I'd be interested to know how OOM and page reclaim behaves after these patches
(or with a newer kernel).

Thanks,
Nick

-- 
Send instant messages to your online friends http://au.messenger.yahoo.com 
