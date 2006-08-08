Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWHHVJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWHHVJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWHHVJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:09:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20431 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965046AbWHHVJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:09:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Double the per cpu area size
References: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
	<200608071730.47120.ak@suse.de>
	<m1vep4ecd8.fsf@ebiederm.dsl.xmission.com>
	<a762e240608081343r3816b906o7985bde9fbd9b463@mail.gmail.com>
Date: Tue, 08 Aug 2006 15:09:14 -0600
In-Reply-To: <a762e240608081343r3816b906o7985bde9fbd9b463@mail.gmail.com>
	(Keith Mannthey's message of "Tue, 8 Aug 2006 13:43:57 -0700")
Message-ID: <m1u04n5405.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Keith Mannthey" <kmannth@gmail.com> writes:

> On 8/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Andi Kleen <ak@suse.de> writes:
>>
>> >>
>> >>  #include <asm/pda.h>
>> >>
>> >> +#define PERCPU_ENOUGH_ROOM 65536
>
> Is it possible to put this into -mm untill things are sorted?
> 2.6.18-rc3-mm2 x86_64 is still without any per-cpu space for modules.

I think we are sorted (see the later patch to auto size the per cpu
area).  But you should be ok with current -mm if you compile for 64 or
fewer cpus.

Eric
