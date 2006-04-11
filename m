Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWDKOPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWDKOPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDKOPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:15:51 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:33186 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751387AbWDKOPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:15:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yiCY71vb7pMCdH7IFC9CO7qoc9R4jUyyTaPRBlod5/feTGRuCuM4Zxb5/1GLyY//YvMl6emEcJsnlmWOTkF7BAtKlyPQ2Yx2nZ6yb9rfRvGpjDqBiOGqP9kW/odt40y+AgRIpz6a3jtNJXBZ6qVgFOxYDC7CPGpH5Jcuyhrtkso=  ;
Message-ID: <443B8F89.8070608@yahoo.com.au>
Date: Tue, 11 Apr 2006 21:14:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>	<4428FB29.8020402@yahoo.com.au>	<20060328142639.GE14576@MAIL.13thfloor.at>	<44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442B4FD6.1050600@yahoo.com.au> <443B85B4.7030009@sw.ru>
In-Reply-To: <443B85B4.7030009@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>> Yes... about that; if/when namespaces get into the kernel, you guys
>> are going to start pushing all sorts of per-container resource
>> control, right? Or will you be happy to leave most of that to VMs?
> 
> 
> Nick, OpenVZ, for example, uses "User Bean Counters" patch originally 
> developed by Alan Cox. The good thing is that it is fully separate from 
> virtualization and allows to control any users or set of processes. 
> Don't you think it is valuable and helpful feature itself? Why are you 
> afraid of resource management?

I'm afraid of resource management because I've seen things like the
ckrm cpu resource manager.

Considering we tend to mostly have only per-process resource management,
low level virtualisation seems like a much better place to do this.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
