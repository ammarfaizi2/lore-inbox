Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWFRGlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWFRGlT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFRGlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:41:19 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36517 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751104AbWFRGlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:41:19 -0400
Message-ID: <4494F549.7040605@vilain.net>
Date: Sun, 18 Jun 2006 18:40:09 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vatsa@in.ibm.com, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <4494EE86.7090209@yahoo.com.au>
In-Reply-To: <4494EE86.7090209@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
>> The answer is quite simple, people who are consolidating systems and 
>> working with fewer, larger systems, want to mark processes, groups of 
>> processes or entire containers into CPU scheduling classes, then 
>> either fair balance between them, limit them or reserve them a 
>> portion of the CPU - depending on the user and what their 
>> requirements are. What is unclear about that?
>>
>
> It is unclear whether we should have hard limits, or just nice like
> priority levels. Whether virtualisation (+/- containers) could be a
> good solution, etc.

Look, that was actually answered in the paragraph you're responding to. 
Once again, give me a set of possible requirements and I'll find you a 
set of users that have them. I am finding this sub-thread quite redundant.

> If you want to *completely* isolate N groups of users, surely you
> have to use virtualisation, unless you are willing to isolate memory
> management, pagecache, slab caches, network and disk IO, etc.

No, you have to use separate hardware. Try to claim otherwise and you're 
glossing over the corner cases.

Sam.

