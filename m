Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265217AbUD3Sqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUD3Sqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUD3Sq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:46:29 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:11428 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S265217AbUD3SqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:46:18 -0400
In-Reply-To: <87zn8tmkd6.fsf@sanosuke.troilus.org>
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet> <40927417.6040100@nortelnetworks.com> <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com> <40927F6F.9020907@canalmusic.com> <765C53A8-9AC6-11D8-B83D-000A95BCAC26@linuxant.com> <87zn8tmkd6.fsf@sanosuke.troilus.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A8F43910-9AD6-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 14:46:15 -0400
To: Michael Poole <mdpoole@troilus.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 30, 2004, at 1:44 PM, Michael Poole wrote:

> Marc Boucher writes:
>
>> I am not threatening anyone, only reminding folks that making
>> unsubstantiated public allegations that unfairly damage a person or
>> company's reputation is wrong and generally illegal.
>>
>> Marc
>
> I do not think the allegations are unsubstantiated or unfair;

A number of allegations were clearly wrong. Some posters have even 
admitted or even criticized these factually incorrect accusations. 
Instead of wasting more time/energy arguing or litigating, we hope that 
this debate will now end peacefully and have helped to clarify and 
resolve problems.

> on the
> contrary, people have identified with specificity what is offensive
> and probably illegal.  Might I remind you of 17 USC 1201(b)(1):

It is extremely ironic that the free software community who was so 
strongly opposed to the DMCA and considering it so evil now invokes it 
in such a far fetched manner (Alan Cox was probably cynical about this 
but you don't seem to be). It is also far from clear whether tainting 
and the MODULE_LICENSE() macro are a "technological measure that 
effectively protects" anything.

Again, our workaround is purely cosmetic, its side-effect on tainting 
totally unintentional, we are sorry that it has caused so much concern 
and we will be fixing it in good faith (even if it is a broken 
concept), while hoping that the underlying problems will be correctly 
resolved in future kernels/modutils.

On Apr 30, 2004, at 2:01 PM, Timothy Miller wrote:
>
> Nope.  The real objection was misleading people about the license of 
> the module.  That part was clearly wrong.

We did not mislead people. Our license terms are clear and openly 
stated in many places.
You could perhaps argue that we "mislead" a string comparison to fix a 
usability problem, but this kind of technique is very common today, 
especially under Linux where numerous interfaces are simulated. Would 
you pretend that things like Wine are wrong and misleading when making 
windows software believe that it runs under the real thing?

Marc

>
>     No person shall manufacture, import, offer to the public, provide,
>     or otherwise traffic in any technology, product, service, device,
>     component, or part thereof, that -
>
> (A) is primarily designed or produced for the purpose of circumventing
>     protection afforded by a technological measure that effectively
>     protects a right of a copyright owner under this title in a work
>     or a portion thereof;
>
> (B) has only limited commercially significant purpose or use other
>     than to circumvent protection afforded by a technological measure
>     that effectively protects a right of a copyright owner under this
>     title in a work or a portion thereof; or
>
> (C) is marketed by that person or another acting in concert with that
>     person with that person's knowledge for use in circumventing
>     protection afforded by a technological measure that effectively
>     protects a right of a copyright owner under this title in a work
>     or a portion thereof.
>
> Issuing the taint warning when a derivative work is created is a right
> of the copyright owner(s); you have explained the embedded \0 as a
> "mere" technical measure designed to circumvent the taint warning.  In
> my reading, that qualifies it as a violation of the paragraph above.
>
> Part or all of 12 USC 1202 may also apply for similar reasons.
>
> The DMCA may be unpopular, but it is still law.
>
> Michael Poole (who is not a lawyer)
>

