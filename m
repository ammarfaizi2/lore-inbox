Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVADXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVADXVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVADXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:13:37 -0500
Received: from smtpout.mac.com ([17.250.248.89]:48861 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262163AbVADXIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:08:10 -0500
In-Reply-To: <200501042058.j04KwFED002211@laptop11.inf.utfsm.cl>
References: <200501042058.j04KwFED002211@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6D2E0FC1-5EA5-11D9-A816-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Wed, 5 Jan 2005 00:07:37 +0100
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2005, at 21:58, Horst von Brand wrote:

> Felipe Alfaro Solana <lkml@mac.com> said:
>> On 4 Jan 2005, at 14:27, Horst von Brand wrote:
>>> Felipe Alfaro Solana <lkml@mac.com> said:
>
> [...]
>
>>>> I think new developments will force a 2.7 branch: when 2.6 feature 
>>>> set
>>>> stabilizes, people will keep more time testing a stable, relatively
>>>> static kernel base, finding bugs, instead of trying to keep up with
>>>> changes.
>
>>> And when 2.7 opens, very few developers will tend 2.6; and as 2.7
>>> diverges from it, fewer and fewer fixes will find their way back. And
>>> so you finally get a rock-stable (== unchanging) 2.6, but hopelessly
>>> out of date and thus unfixable (if nothing else because there are no
>>> people around who remember how it worked).
>
>> I can see no easy solution for this... If Linus decides to fork off
>> 2.7, development efforts will go into 2.7 and fixes should get
>> backported to 2.6. If Linus decides to stay with 2.6, new development
>> will have to be "conservative" enough not to break things that were
>> working.
>
> Exactly.
>
>> I tend to prefer forking off 2.7: more agressive features can be
>> implemented and tested without bothering disrupting the stable 2.6
>> branch.
>
> Have any particular features in mind? If you have some, you can fork 
> off
> your own BK repository and play there (wait... that is how (currently)
> out-of-tree drivers are developed!). Or you could start an unofficial
> experimental fork. If none of the above, I guess you'd just have to 
> wait
> until Our Fearless Leader decides it is time for 2.7.
>
> Just forcing a 2.7 "because that'll stabilize 2.6" is nonsense. Because
> then 2.6 won't stabilize any faster (probably slower).

Stabilizing, for me at least, means fixing bugs, not adding new 
features (unless those new features are totally necessary). Thus, I 
don't see how freezing the 2.6 codebase, waiting some time for bugs to 
get fixed and things to settle down, then forking off 2.7 could be a 
non-sense.

