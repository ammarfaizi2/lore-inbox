Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVE0IRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVE0IRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVE0IRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:17:33 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:11918 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261985AbVE0IRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:17:17 -0400
Message-ID: <4296D785.2050600@yahoo.com.au>
Date: Fri, 27 May 2005 18:17:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       bhuey@lnxw.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050525005942.GA24893@nietzsche.lynx.com>	 <1116982977.19926.63.camel@dhcp153.mvista.com>	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>	 <20050526193230.GY86087@muc.de>	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>	 <20050526202747.GB86087@muc.de>  <4296ADE9.50805@yahoo.com.au> <1117178430.6138.16.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1117178430.6138.16.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich wrote:
> On Fri, 2005-05-27 at 15:19 +1000, Nick Piggin wrote:
> 
>>Or have I missed something completely? You RT guys have thought about
>>it - so what are some pros of the Linux-RT patch and/or cons of the
>>nanokernel approach, please?
>>
> 
> 
> Sorry Nick,
> 

Hi Sven,

> The discussion about sub-kernels does not need to happen again in this
> forum.
> 

I never saw it happen in this forum. I believe you if you say it
has, but I suspect a lot has changed since then.

> We have made more than enough noise about RT already, and taken
> bandwidth that people are using to do real work.
> 

These days you have to say something pretty stupid to worsen
the noise ratio on lkml ;) People manage to get real work done, so
don't worry about that.

What's more, this is actually a discussion that I hope *will* be
productive.

> There are different application domains, and nano-kernels have theirs.
> 
> If you are truly interested, there are a lot of papers about RT. There
> are nanokernel implementations and patents you can review, and there is
> a lot of controversy.
> 

What do you mean "truly interested"? Of course, that is why I asked.
I am not so much interested from the "I want to build an RT control
system" point of view as from "I want to get some background info on
changes that might soon be proposed to our kernel".

And that is why it is relevant on this forum. In that context (ie.
having a patch included) it is not up to us to go wading through years
of old debate, research and discussion. But whoever will propose the
RT patch to be included simply needs to come up with the rationale
and basically address people's concerns.

So unless the conclusion of your previous discussion was Linus and
Andrew saying "yes, we'll go with solution 'blah'", then it absolutely
is necessary to get the issues out in the open.

However I don't think think it would be too much to ask if you want
to be removed from CC list on the rest of the thread.

> I would refer you to LKML the archives, going back a few years, where
> you can find answers to all your questions.
> 

A few *years* ago? No thanks.

> The opinion you form in the end may depend largely on what you read,
> whom you talk to, your understanding of how everything interacts, and
> your intuition.
> 
> If you have any remaining specific questions, I'll be glad to point you
> to more information (OFF LIST)

lkml is a great forum for almost any kernel development discussion,
especially something like this.

I had some specific questions in my previous email. The main thing
I guess, is "why not a nanokernel?". I am also very interested in the
applications that will require PREEMPT_RT too.

Don't take my questions personally or as an attack against the patch.
This kind of discussion always happens, and always surrounds moderately
large changes proposed to the kernel. (I'm not saying you won't get
flames, but this really isn't one).

> 
> (I hope that puts it back in the box)
> 

Actually it doesn't at all, but thanks anyway ;)

Thanks,
Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
