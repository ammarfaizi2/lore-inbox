Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUCYAyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUCYAyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:54:45 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:61607 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262611AbUCYAyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:54:41 -0500
Date: Thu, 25 Mar 2004 08:50:27 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Cc: "Nigel Cunningham" <ncunningham@users.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>,
       "Andrew Morton" <akpm@osdl.org>
References: <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz> <opr5ci61g54evsfm@smtp.pacific.net.th> <20040324101704.GA512@elf.ucw.cz> <opr5d1jave4evsfm@smtp.pacific.net.th> <20040324232338.GE290@elf.ucw.cz> <opr5d4r0il4evsfm@smtp.pacific.net.th> <20040325002302.GG290@elf.ucw.cz>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr5d7ad0b4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040325002302.GG290@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 01:23:02 +0100, Pavel Machek <pavel@ucw.cz> wrote:

> On Čt 25-03-04 07:56:14, Michael Frank wrote:
>> On Thu, 25 Mar 2004 00:23:38 +0100, Pavel Machek <pavel@ucw.cz> wrote:
>> >On Čt 25-03-04 06:46:12, Michael Frank wrote:
>> >>On Wed, 24 Mar 2004 11:17:04 +0100, Pavel Machek <pavel@ucw.cz> wrote:
>
>> >Yes, having -nice patch with bootsplashes, translated kernel messages,
>> >and swsusp eye-candy would work for me.
>>
>> If a -nice _tree_ is useful, your guys just have to launch it. Gosh this
>> could reduce
>> arguments about what goes into the kernel and save Linus and Andrew lots of
>> work.
>
> Yes.
>
>> >Feel free to maintain it.
>>
>> Busy enough with testing, actually far too busy for being on a volunteer
>> basis ;)
>>
>> I am sure that better qualified and properly supported/sponsored individuals
>> will queue up as long as it is an _official_ -nice tree with the good
>> purpose
>> of centralizing useful non-core functions :)
>
> I'd say that having official -anything tree is an oxymoron (is -ac
> tree official? is -mm tree official?), but yes, I hope someone picks
> this up

-mm or -ac are "private trees", albeit very credible and at least -mm is
experimental.

Linux is now 10 times as big as it was a few years ago, OK tools are better,
but there is so much important work like PM waiting.

If Linus or Andrew and peers said, OK bootsplash, or kgdb or whatever
is nice "enough",  but I do not have time to deal with it, put it into the -nice tree,
it would be "official" enough.

And if for that matter all of swsusp would end up in _the_  -nice tree
(not crippled of course), that would be (_speaking_for_myself)
(sorry Nigel, should you disagree) also OK.

Then after all, -nice can then be much nicer than -Linus without many fights
and accomplishing more than ever ;).

>
>> >You see, 10 lines in printk is probably good enough reason not to
>> >include that patch in kernel, because its "too ugly".
>>
>> Pretty does not count above, Ugly does not count here, Functionality always
>> does.
>> Besides that patch might be in the -nice tree.
>
> Prettyness *does* count in -linus tree. -nice tree is likely to have
> different criteria.

As this may be another religious war, I'll give up.

>
>> >swsusp really should not have patch any code outside kernel/power.
>>
>> Which is extremely ideal, but one thing at the time...
>
> Okay, lets not please add more of outside changes (for -linus merge).

Fine by me as long as it works.

Guess Nigel will come up with a spec soon and then it has to be decided
what functions you want in -Linus.

I'll be traveling a few days and may be slower to respond.

Michael
