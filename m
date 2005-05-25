Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVEYHV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVEYHV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVEYHVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:21:11 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:23485 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262312AbVEYHSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:18:39 -0400
Message-ID: <429426C9.8040901@yahoo.com.au>
Date: Wed, 25 May 2005 17:18:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Sven Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
In-Reply-To: <20050525063306.GC5164@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>Sven Dietrich <sdietrich@mvista.com> wrote:
>>
>>>I think people would find their system responsiveness / tunability
>>> goes up tremendously, if you drop just a few unimportant IRQs into
>>> threads.
>>
>>People cannot detect the difference between 1000usec and 50usec 
>>latencies, so they aren't going to notice any changes in 
>>responsiveness at all.
> 
> 
> i agree in theory, but interestingly, people who use the -RT branch do 
> report a smoother desktop experience. While it might also be a 
> psychological effect, under -RT an interactive X process has the same 
> kind of latency properties as if all of the mouse pointer input and 
> rendering was done in the kernel (like some other desktop OSs do).
> 
> so in terms of mouse pointer 'smoothness', it might very well be 
> possible for humans to detect a couple of msec delays visually - even 
> though they are unable to notice those delays directly. (Isnt there some 
> existing research on this?)

I'm guessing not, just because the monitor probably hasn't even
refreshed at that point ;) But...

[...]
> 
> [ of course this is all just talk, but people seem to have a desire to
>   talk about it :-) ]
> 

You make good points. What's more, I don't think anyone needs to
advocate the RT work on the basis that it improves interactiveness.
That path is just going to lead to unwinnable arguments and will
distract from the real measurable improvements that it does bring.

I think anyone who doesn't like that won't be convinced because
someone is telling them it improves interactiveness ;)

Now lest I create a negative image of myself, I'd like to say that
without looking at the code, it sounds quite nice and if it can be
nicely encapsulated and CONFIGurable then I don't see why it
can't eventually be included.
Send instant messages to your online friends http://au.messenger.yahoo.com 
