Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbUCZGGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbUCZGEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 01:04:24 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:17136 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263619AbUCZGEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 01:04:11 -0500
Date: Fri, 26 Mar 2004 13:59:55 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: swsusp is not reliable. Face it. [was Re: [Swsusp-devel] Re: swsusp problems]
Cc: "Jonathan Sambrook" <jonathan.sambrook@dsvr.co.uk>,
       linux-kernel@vger.kernel.org,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net> <20040324151831.GB25738@atrey.karlin.mff.cuni.cz> <20040324202259.GJ20333@jsambrook> <opr5dwwgzi4evsfm@smtp.pacific.net.th> <20040325221348.GB2179@elf.ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5gf95na4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040325221348.GB2179@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to leave the header ;)

On Thu, 25 Mar 2004 23:13:48 +0100, Pavel Machek <pavel@ucw.cz> wrote:

>
>> Suspend is a mechanism to suspend the system transparently and
>> _NOT_EVER_ impairing the system. There can be NO_COMPROMISE and
>> NO_EXCUSE. I walk out of my office suspending the machine and resuming it
>> in front of my client it can't ever fail, or am I an idiot to advocate
>> linux?
>>
>> If I would be willing to accept failure I would not spend my time here and
>> utilize M$'s  incarnation of an architectural idiocy.
>
> You are wrong.
>
> swsusp1 fails your test, swsusp2 fails your test, and pmdisk fails it,
> too. If half of memory is used by kmalloc(), there's no sane way to
> make suspend-to-disk working. And swsusp[12] does not. Granted, half
> of memory kmalloc-ed is unusual situation, but it can theoreticaly
> happen. Try mem=8M or something.

No, I am not!

mem=8M won't boot into a usable system. mem=~11M will not suspend and
swsusp2 will exit gracefully and this is tested.

So swsusp2 does _not_ fail. You still have a usable system instead of a
paniced system you seem to like to accept.

Regards
Michael
