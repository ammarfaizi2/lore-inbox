Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314659AbSD1Bln>; Sat, 27 Apr 2002 21:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314658AbSD1Blm>; Sat, 27 Apr 2002 21:41:42 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:60172 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314657AbSD1Bll>;
	Sat, 27 Apr 2002 21:41:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Richard Thrapp <rthrapp@sbcglobal.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message 
In-Reply-To: Your message of "27 Apr 2002 20:27:07 EST."
             <1019957228.8818.109.camel@wizard> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Apr 2002 11:41:30 +1000
Message-ID: <32711.1019958090@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Apr 2002 20:27:07 -0500, 
Richard Thrapp <rthrapp@sbcglobal.net> wrote:
>On Sat, 2002-04-27 at 19:27, Keith Owens wrote:
>> On Sat, 27 Apr 2002 16:20:03 +0100 (BST), 
>> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> >How about
>> >
>> >Warning: The module you have loaded (%s) does not seem to have an open
>> >	 source license. Please send any kernel problem reports to the
>> >	 author of this module, or duplicate them from a boot without
>> >	 ever loading this module before reporting them to the community
>> >	 or your Linux vendor
>> 
>> I'm going for the current message followed by "See <URL> for more
>> information".  <URL> defaults to http://www.tux.org/lkml/#s1-18,
>> vendors who want to point to their policy text can override the URL
>> when they build modutils.
>
>Why did you tell me to ask here and go with what Alan said if you
>weren't going to listen to the discussion?  Alan's message corrects all
>of the problems we found.  Several people agreed on the basic form.  If
>you weren't going to go with the agreed upon result, why did you have me
>ask here?  You just wasted a lot of our time.  You should have just told
>me earlier that you weren't going to correct it -- I would have accepted
>the decision.

The discussion was useful.  I choose to agree with the people who
suggested a URL rather than with Alan's suggestion of an expanded
message.  It allows vendors who want to support their customers
directly to add a reference to their policy and remove the load from
l-k.

That is what discussion is for, to bring out possibilities.  If you
don't like my decision you are free to ship and maintain your own
modified version of modutils.

>I get sick and tired of maintainers who solicit opinions and then refuse
>to listen to the answers they get back, even when people who know what
>they are doing agree... even when the majority agrees.  I've seen it
>happen many times.  I know it's the maintainer's choice in the end, but
>don't ask for community opinions unless you're going to listen to them. 
>It's insulting and infuriating.

Translation:  "I don't like the decision so I will complain about the
maintainer".  See above.

>I provide a module, not a distribution.  I've found that people want to
>choose their distribution, even sometimes in embedded space, so I let
>them (and I have no interest in providing a distribution anyway).  I
>cannot control what modutils they run.  But I get bug reports back on
>the module due to the tainted message.

That is one of the many costs you have to bear for shipping binary only
modules.  I am not going to make life easier for you.  In your original
message to me you made no mention of the fact that you are shipping
binary only modules, if I had know that in advance I would not have
tried to help you, now you have no credibility with me.

>At the very least, -please- change the verb tense of the message to be
>correct.  That will at least eliminate the "module doesn't load" bug
>reports (I hope).

The verb tense is correct.  The message is issued before the module is
loaded and descibes what is about to occur.

