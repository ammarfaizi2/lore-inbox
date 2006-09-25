Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWIYLzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWIYLzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWIYLzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:55:01 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:31088 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751479AbWIYLzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:55:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BJnfanIvSISW8fe4MdC4fs6p+uLmljEHcJXu7MsKxFL201VGuKeIF2YBDzBOYkVF1wH8VJKdzoreJi99aNwJmW7zQ7zGBpzbXkN+sMiRl5B49wPAkVIBJcTSAMJW8rSYyCaodjqJArMF+dfc6jZug5q82EWMczIHsNSO+lSZ2qY=  ;
Message-ID: <451747EE.50900@yahoo.com.au>
Date: Mon, 25 Sep 2006 13:07:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <20060924185100.GA20524@elte.hu>
In-Reply-To: <20060924185100.GA20524@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>>I think the "big merges in the first two weeks, and a -rc1 after, and 
>>no new code after that" rule has been working because it brought 
>>everybody in on the same page.
>>
>
>yeah. I dont really support the even/odd release thing because even the 
>old 1.2/1.3/2.0/2.1/2.2/2.3/2.4 scheme _always_ confused non-insiders. 
>Sometimes i saw it confuse people who already understood the GPL ;-) 
>Furthermore it would just dillute our version numbers to encode some 
>information that "-rc1" indicates just as well. Insiders know perfectly 
>well that when -rc1 is released the merge window is closed. And what 
>causes -rc elongation is usually not the lack of communication towards 
>users or lack of testing but the lack of fixing power ...
>

OTOH, if we were worried about confusing people, we wouldn't be
using the acronym 'rc' for our 'Ridiculous Count', and have our rc1
denote the result of 2 weeks of stuffing the tree with new features
and intrusive changes, where people might mistake that for the much
more common RC-as-in-'Release Candidate'. :)

Our -rc is what everyone else knows as -pre, and our dot zeros
basically correspond to what people think of as a release candidate.
As a developer it doesn't hurt me and I do like the current system,
but in principle I just dislike things that are more confusing than
they could be.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
