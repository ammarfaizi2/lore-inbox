Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752363AbWCKIQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbWCKIQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbWCKIQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:16:13 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:9871 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752361AbWCKIQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:16:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=d0q9OhJrpVwdxSO/c8HGkVR3XJqRrnqkYKc3NXfa2ZVBtugailo+mN9+E1lvdGU6kExVY7MkVWBNuxRslhDORru3afEPjdqgA4m98v4kFS8BXloswoUS7xkF4NHwDXYeoC7Wwokoz3ILqynIp1Np98JbkxV5WjtUgdCVqOpQNWI=  ;
Message-ID: <44128747.8060800@yahoo.com.au>
Date: Sat, 11 Mar 2006 19:16:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
References: <200603102054.20077.kernel@kolivas.org>	 <1142056851.7819.54.camel@homer> <1142057114.7819.57.camel@homer>	 <200603111820.35780.kernel@kolivas.org> <1142063055.7605.6.camel@homer>
In-Reply-To: <1142063055.7605.6.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sat, 2006-03-11 at 18:20 +1100, Con Kolivas wrote:
>>On Saturday 11 March 2006 17:05, Mike Galbraith wrote:
>>>On Sat, 2006-03-11 at 07:00 +0100, Mike Galbraith wrote:
>>>>On Sat, 2006-03-11 at 16:50 +1100, Con Kolivas wrote:
>>>>>On Saturday 11 March 2006 16:33, Mike Galbraith wrote:
>>>>>>On Sat, 2006-03-11 at 14:50 +1100, Con Kolivas wrote:
>>>>>>>On Saturday 11 March 2006 09:35, Andrew Morton wrote:
>>>>>>>>Con Kolivas <kernel@kolivas.org> wrote:

So... you guys ever think about trimming this? Not only would
it be faster to read, you can save the list server about 15MB
worth of email a pop with just a small haircut.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
