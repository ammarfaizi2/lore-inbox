Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUCKX7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCKX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:59:31 -0500
Received: from alt.aurema.com ([203.217.18.57]:11708 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261846AbUCKX72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:59:28 -0500
Message-ID: <4050FCF9.6070800@aurema.com>
Date: Fri, 12 Mar 2004 10:57:45 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chip Salzenberg <chip@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
References: <E1B1TIJ-0007Tm-Jn@tytlal>
In-Reply-To: <E1B1TIJ-0007Tm-Jn@tytlal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> Amarendra.Godbole@ge.com writes:
> 
>>>As a result, using the former just tends to increase peoples 
>>>confusion by making code harder to read, which in turn tends 
>>>to increase the chance of bugs.
>>
>>Kindly don't insult the kernel developers' with such statements. ;-)
>>They are smart enough to understand such constructs [...]
> 
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

It's got nothing to do with visual scanning.  It's more to do with 
grammatical form i.e. we (especially English speakers) like the form: 
subject (foo) verb (==) object (0); and in these cases the variable 
(foo) is the indisputable subject (i.e. the thing the sentence is about) 
but (0 == foo) momentarily causes us to think that 0 is the subject and 
we find this disconcerting.  On the other hand, Yoda (the Jedi master) 
would probably prefer: (0 foo ==) :-)

Like most matters of style there are points for and against both methods 
  and eventually someone has to make a (relatively arbitrary) decision. 
  Linus has made the decision and it's his call so we should abide by it 
(especially since he made it pretty clear that he was aware of (and 
considered) all the relevant arguments and is therefore unlikely to 
change his mind).

Peter
PS It's important not to get too emotionally attached to a particular 
method or style because there's always a chance that whoever gets to 
decide which will be used may not choose the one you like.  This time 
you lucked in :-)
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

