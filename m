Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWE2IT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWE2IT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWE2IT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:19:56 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:33336 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750762AbWE2IT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:19:56 -0400
Message-ID: <447AAE98.2080409@de.ibm.com>
Date: Mon, 29 May 2006 10:19:36 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, joern@wohnheim.fh-wedel.de,
       ioe-lkml@rameria.de, Martin Peschke <mp3@de.ibm.com>
Subject: Re: [PATCH 09/33] readahead: events accounting
References: <20060524111246.420010595@localhost.localdomain> <348469540.16036@ustc.edu.cn> <20060525093627.4d37e789.akpm@osdl.org> <348735988.17875@ustc.edu.cn>
In-Reply-To: <348735988.17875@ustc.edu.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> On Thu, May 25, 2006 at 09:36:27AM -0700, Andrew Morton wrote:
>> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>>> A debugfs file named `readahead/events' is created according to advises from
>>>  J?rn Engel, Andrew Morton and Ingo Oeser.
>> If everyone's patches all get merged up we'd expect that this facility be
>> migrated over to use Martin Peschke's statistics infrastructure.
>>
>> That's not a thing you should do now, but it would be a useful test of
>> Martin's work if you could find time to look at it and let us know whether
>> the infrastructure which he has provided would suit this application,
>> thanks.
> 
> Hi, Martin is doing a great job, thanks.
> 
> I have read about its doc.  It should be suitable for various
> readahead numbers. And it seems a trivial work to port to it :)

Wu, great :) If you got questions (e.g. on how to setup your statistics so
that the output looks quite compact) or more requirements (like an enhancement
of the code that accumulates numbers) feel free to get back to me.
Thanks, Martin

