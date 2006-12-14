Return-Path: <linux-kernel-owner+w=401wt.eu-S1751786AbWLNRx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWLNRx3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWLNRx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:53:29 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:44376 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbWLNRx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:53:28 -0500
X-Greylist: delayed 41991 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 12:53:27 EST
Message-ID: <45818AFF.4060809@wolfmountaingroup.com>
Date: Thu, 14 Dec 2006 10:33:51 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Woodhouse <dwmw2@infradead.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>  <20061214005532.GA12790@suse.de>  <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <1166084480.5253.849.camel@pmac.infradead.org> <Pine.LNX.4.64.0612140838410.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612140838410.5718@woody.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Again, I agree with EVERY statement Linus made here. We operate exactly 
as Linus describes, and
legally, NO ONE can take us to task on GPL issues. We post patches of 
affected kernel code
(albiet the code resembles what Linus describes as a "skeleton driver") 
and our proprietary
non derived code we sell with our appliances. He is right, everyone else 
should just accept
it and get on with life or cry linus a river.

Jeff

Linus Torvalds wrote:

>On Thu, 14 Dec 2006, David Woodhouse wrote:
>  
>
>>But I would ask that they honour the licence on the code I release, and
>>perhaps more importantly on the code I import from other GPL sources.
>>    
>>
>
>This is a total non-argument, and it doesn't get any betetr by being 
>mindlessly repeated over and over and over again.
>
>The license on the code you released talked about "derived works".
>
>Not "everything I want to".
>
>If a module owner can argue successfully in a court of law that a binary 
>driver isn't a derived work, then the GPL simply DOES NOT COVER IT!
>
>In other words, people CAN "honor the license" and still not be required 
>to put their code under the GPL.
>
>And no, including one header file in order to compile against something 
>does not automatically make something a "derived work". It may, or it may 
>not. It really isn't up to you to decide whether it does (and notice how 
>I'm not saying that it's up to _me_ either!).
>
>For example, all the same people who clamor for free software get 
>absolutely RABID about "fair use". Guess what "fair use" actually MEANS? 
>
>Think about it for a moment. It expressly _limits_ the right of copyright 
>authors to claim "derived work". So if you argue that anything that ever 
>includes your header file (but none of your code) and compiles against it 
>is a "derived work", then you are basically very close to arguing that 
>"fair use" does not exist.
>
>Do you really want to argue that "everything that has touched anything 
>copyrighted AT ALL is a derived work"? Do you feel lucky, punk?
>
>THAT is why I think this discussion is so hypocritical. Either you accept 
>that "fair use" and copyrights aren't black-and-white, or you don't.
>
>If you think this is a black-and-white "copyright owners have all the 
>rights", then you're standing with the RIAA's and the MPAA's of the world.
>
>Me, personally, I think the RIAA and the MPAA is a shithouse. They are 
>immoral. But guess what? They are immoral exactly _because_ they think 
>that they automatically own ALL the rights, just because they own the 
>copyright.
>
>That is what it boils down to: copyright doesn't really give you "absolute 
>power". This is why I have been _consistently_ arguing that we're not 
>about "black and white" or "good against evil". It simply isn't that 
>simple.
>
>I don't like binary modules. I refuse to support them, and if it turns out 
>that the module was written using Linux code, and just for Linux, I htink 
>that's a _clear_ copyright violation, and that binary module is obviously 
>a license violation.
>
>But if the module was written for other systems, and just ported to Linux, 
>and not using our code, then it's very much debatable whether it's 
>actually a "derived work". Interfaces don't make "derived works" per se. 
>
>Now, is it something you could sue people over? Sure. I actually do 
>believe that it's very possible that a judge _would_ consider such a 
>module a derived work, and you can sue people. It probably depends on 
>circumstances too. 
>
>But don't you see the problem with a black-and-white technical measure?
>
>Don't you see the problem with the DMCA and the DVD encryption? 
>
>Those kinds of things REMOVE the "reasonable thought" from the equation, 
>and turn a gradual process into a sharp "right or wrong" situation. AND 
>THAT IS WRONG. We simply do not LIVE in a world that is black and white.
>
>So if you think somebody violates your copyright, send them a C&D letter, 
>and eventually take them to court. It's been done. Companies that mis-used 
>the GPL have actually been sued, and THEY HAVE LOST. That's a GOOD thing. 
>I'm not arguing against that at all. What I'm arguing against is the 
>"blind belief" that you or I have the right to tell people what to do, 
>just because we own copyrights.
>
>It's not a blind belief that I'm willing to subscribe to. Exactly because 
>I have _seen_ what that blind belief results in - crap like the DMCA and 
>the RIAA lawsuits.
>
>			Linus
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

