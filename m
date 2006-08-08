Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWHHH34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWHHH34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWHHH34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:29:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15330 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932519AbWHHH3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:29:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86_64:  Auto size the per cpu area.
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<200608080801.29789.ak@suse.de>
	<m1lkpz9134.fsf@ebiederm.dsl.xmission.com>
	<200608080848.03054.ak@suse.de>
Date: Tue, 08 Aug 2006 01:29:26 -0600
In-Reply-To: <200608080848.03054.ak@suse.de> (Andi Kleen's message of "Tue, 8
	Aug 2006 08:48:03 +0200")
Message-ID: <m1zmef7kix.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> >
>> > However not that particular patch - i already changed that
>> > code in my tree because I needed really early per cpu for something and
>> > i had switched to using a static array for cpu0's cpudata.
>> >
>> > I will modify it to work like your proposal.
>> 
>> Sounds good to me.
>
> Actually i ended up going with your patch and dropping mine
> because of some other issues and I solved the problem
> that caused me to do the other in a different way.

Ok.

Since this is the agreed upon path, Andrew can you please pick
this patch up for the next -mm release?

Then the final practical question does it still make sense to decouple
the NR_IRQS from NR_CPUS?  As my other patch was doing?

Eric
