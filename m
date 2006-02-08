Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWBHAwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWBHAwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWBHAwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:52:37 -0500
Received: from [202.131.75.34] ([202.131.75.34]:58082 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S1030323AbWBHAwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:52:36 -0500
Message-ID: <43E940BF.7020203@shaolinmicro.com>
Date: Wed, 08 Feb 2006 08:52:15 +0800
From: David Chow <davidchow@shaolinmicro.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com> <43E8F8EB.8010800@shaolinmicro.com> <20060207221513.GA7394@thunk.org>
In-Reply-To: <20060207221513.GA7394@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Every Linux developer has their own goals, of course, but for most of
>them it is about making the best possible Linux kernel that is
>technically possible.  If they have working drivers for their system,
>they may not necessarily care about some company's hardware unless,
>(a) it impacts them personally, (b) they are paid or employed to worry
>about it, or (c) lots of end-users are sending complaining/sending
>hate-mail about it. 
>  
That's expected. IS there a composition statistics about the LKML? I 
guess near 100% are technical people here, including me.
>(In some cases, end-users send hate mail to the Linux kernel
>developers when some idiot company's binary driver modules is buggy
>and corrupts the kernel in hard-to-debug ways; one particular video
>driver company is especially guilty here, and is viewed by some as
>being directly responsible for the tainted kernel flags.)
>
>The assumption by many developers is that if we concetrate on making
>Linux as good as possible, it will eventually get popular enough that
>hardware vendors will feel a commercial incentive to cooperate with
>our way of doing things.  Obviously, this in practice things don't
>always work that way --- the Sony Betamax is story is one where
>technical excellence doesn't always win out.  However, at least in the
>server space, compromising hasn't obviously been a bad strategy, with
>many SCSI and FC controller manufacturers deciding on their own to
>work with the Linux kernel development community.  (Sometimes with
>some help from major system vendors who write in a requirement for a
>mainline device driver into the sourcing contracts for said
>controllers, but nevertheless, it shows that this stance is not
>obviously a bad strategy for Linux kernel developers, at least in the
>server space.)
>
>David, you may find this frustrating, and at least in the Deskstop
>space, it's likely that your company hasn't seen sourcing contracts
>yet where a mainline acceptable device driver is a requirement for
>some major system vendor, like Dell, Gateway, HP, etc. to decide to
>use your products.  I suspect that if this _was_ the case, your
>  
No, I never had drivers problems . Because we have our own stable 
partial_kernel_API to bare this problem and kept all supported kernel 
sources and headers maintained.
>company would in fact dedicate the full-time engineer necessary to
>make a device driver which could be integrated into the mainstream
>kernel sources and then could be backported to older distributions.
>But if you did, I think it is certainly doable.
>  
Yes it worked for us. But what about others? I don't think everyone that 
want to support Linux have to do that. We are different, because we only 
support Linux, so we dare to do that. Other companies have to do 
Windows, Unix and possibly other OS. This way don't seems feasible for them.
Back-port?
>But at that point it stops being a technical question of "is it
>possible" and moves to an economic question of "are we willing to fund
>a full-time engineer to provide support for our hardware under Linux"
>and "how popular does the Linux desktop have to be before a system
>vendor will feel obliged to put pressure on their downstream suppliers
>to provide the necessary driver support"?  And as such, LKML will
>probably not be a very useful place to have that discussion.
>  
I have no expectation the LKML will agree to my point . Because 99% of 
the LKML are likely technical users and community developers. As said, 
they only care about programming drivers in the kernel source. Freedom 
of change is cool and fun for them.


regards,
David Chow
