Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUCLBv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCLBvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:51:25 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:51949 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261905AbUCLBvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:51:22 -0500
In-Reply-To: <E1B1TIJ-0007Tm-Jn@tytlal>
References: <E1B1TIJ-0007Tm-Jn@tytlal>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BCE0CC77-73C7-11D8-BAF8-000A958E2366@mn.rr.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Chris Johns <cbjohns@mn.rr.com>
Subject: Re: (0 == foo), rather than (foo == 0)
Date: Thu, 11 Mar 2004 19:51:11 -0600
To: Chip Salzenberg <chip@pobox.com>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to throw a little more gas on this particular fire (or maybe
some water, depending on your point of view), when I worked for a while
at the Evil Empire, the "const == variable" comparison was mandatory in
the group I worked in. Odd to look at initially, I'll admit, but it 
still caught
several potential bugs. One other thing that was mandatory was to
set to NULL any pointer to memory area that was freed immediately after
freeing it. Again, a good idea, although not a coding style issue.

Chris


On Mar 11, 2004, at 10:44 AM, Chip Salzenberg wrote:

> Amarendra.Godbole@ge.com writes:
>>> As a result, using the former just tends to increase peoples
>>> confusion by making code harder to read, which in turn tends
>>> to increase the chance of bugs.
>>
>> Kindly don't insult the kernel developers' with such statements. ;-)
>> They are smart enough to understand such constructs [...]
>
> It's not about intelligence!  It's about the nature of human visual
> pattern-matching.  Reading a pattern is always easier when you've seen
> it thousands of times before.
>
> Henry Spencer's dictum about brace style seems particularly apropos:
>
> 8.  Thou shalt make thy program's purpose and structure clear to thy
>     fellow man by using the One True Brace Style, even if thou likest
>     it not, for thy creativity is better used in solving problems than
>     in creating beautiful new impediments to understanding.
>
> And that's what "0 == foo" is: an impediment to understanding.
> -- 
> Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
> "I wanted to play hopscotch with the impenetrable mystery of existence,
>     but he stepped in a wormhole and had to go in early."  // MST3K
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

