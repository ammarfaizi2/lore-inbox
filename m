Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUCXDQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 22:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbUCXDQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 22:16:39 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:14588 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262987AbUCXDQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 22:16:37 -0500
Date: Wed, 24 Mar 2004 11:12:27 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@suse.cz>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>,
       "Andrew Morton" <akpm@osdl.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5ci61g54evsfm@smtp.pacific.net.th>
In-Reply-To: <20040323234449.GM364@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 00:44:49 +0100, Pavel Machek <pavel@suse.cz> wrote:

> Hi!
>
>> > Well, I'd hate
>> >
>> > Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
>> > Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472
>> >
>> > to be obscured by progress bar.
>>
>> So why aren't you arguing against bootsplash too? That definitely
>> obscures such an error :> Of course we could argue that such an error
>> shouldn't happen and/or will be obvious via other means (assuming it
>> indicates hardware failure).
>
> Of course I *am* against bootsplash. Unfortunately I've probably lost
> that war already. But at least it is not in -linus tree (and that's
> what I use anyway) => I gave up with bootsplash-equivalents, as long
> as they don't come to linus.
>
> [And I believe Linus would shoot down bootsplash-like code, anyway.]
>
> 								Pavel

Solution: Auto switch to non-swsusp VT on error showing the error message.

Michael
