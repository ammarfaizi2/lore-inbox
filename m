Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWDKOhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWDKOhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWDKOhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:37:14 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:59029 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751303AbWDKOhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:37:13 -0400
Message-ID: <443BC0BC.4000600@sw.ru>
Date: Tue, 11 Apr 2006 18:44:12 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>	<4428FB29.8020402@yahoo.com.au>	<20060328142639.GE14576@MAIL.13thfloor.at>	<44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442B4FD6.1050600@yahoo.com.au> <443B85B4.7030009@sw.ru> <443B8F89.8070608@yahoo.com.au>
In-Reply-To: <443B8F89.8070608@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nick, OpenVZ, for example, uses "User Bean Counters" patch originally 
>> developed by Alan Cox. The good thing is that it is fully separate 
>> from virtualization and allows to control any users or set of 
>> processes. Don't you think it is valuable and helpful feature itself? 
>> Why are you afraid of resource management?
> 
> 
> I'm afraid of resource management because I've seen things like the
> ckrm cpu resource manager.
Ohhhhh... Now I see :)
CKRM is using too much heavy framework, with hierarchical settings and 
so on, but little practical things.

Our approach is totally different, we make it simple and straitforward 
and all resource management features are compile-time configurable.

> Considering we tend to mostly have only per-process resource management,
> low level virtualisation seems like a much better place to do this.
it depends. if you want trully secure environment in Linux, resource 
management is a MUST. Also, per-process management is not natural from 
user POV.

Thanks,
Kirill

