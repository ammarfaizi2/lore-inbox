Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUFJPLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUFJPLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUFJPLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:11:06 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:23053 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261576AbUFJPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:11:04 -0400
Message-ID: <40C87DAF.902@techsource.com>
Date: Thu, 10 Jun 2004 11:26:39 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org> <40C87934.2060505@techsource.com> <Pine.LNX.4.58.0406100754270.2050@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406100754270.2050@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>>If you really want to force user space accesses to follow certain rules, 
>>make them longs or structs (or at least void *) (depending on 
>>architecture) so that only the proper user-space-access functions can 
>>interpret them.
> 
> 
> .. and this would be a total disaster.
> 
> Think about it. The user pointer isn't just a "value". It has a type it 
> points to. We want to do


Makes sense.  Too many things my short-sighted suggestion didn't account 
for.


