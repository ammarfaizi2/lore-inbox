Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVANTSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVANTSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVANTQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:16:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:54476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262057AbVANTPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:15:55 -0500
Date: Fri, 14 Jan 2005 11:15:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050114183415.GA17481@thunk.org>
Message-ID: <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
 <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
 <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain>
 <20050113194246.GC24970@beowulf.thanes.org> <20050113200308.GC3555@redhat.com>
 <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org>
 <1105644461.4644.102.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org> <20050114183415.GA17481@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, Theodore Ts'o wrote:
> 
> 	But please reflect that the glory-hounds would in fact get
> more attention if they were to announce their findings right away,
> along with the exploit that does something public and visible, such as
> taking down kernel.org ---- and that sometimes the security
> researchers who insist on delayed disclosure are doing so out of the
> best of intentions, and will only work with organizations that repsect
> their requests.  You may not agree with them, but name calling is not
> going to help matters.

I disagree violently.

What vendor-sec does is to make it "socially acceptable" to be a parasite. 

I personally think that such behaviour simply should not be encouraged. If
you have a security "researcher" that has some reason to delay his
disclosure, you should see for for what he is: looking for cheap PR. You
shouldn't make excuses for it. Any research organization that sees PR as a
primary objective is just misguided.

Also, there's a more fundamental issue: the "glorification" of bugs. Bugs
aren't news. We have various small bugs all the time, and many of them are
at least potential local DoS issues. Suppression of information is what
_makes_ these bugs news.

So I dislike the _culture_ that vendor-sec encourages. THAT is the real
problem. And hey, it may be better than some other places. Goodie. But
dammit, it needs somebody to be critical about it too.

What's the alternative? I'd like to foster a culture of

 (a) accepting that bugs happen, and that they aren't news, but making 
     sure that the very openness of the process means that people know
     what's going on exactly because it is _open_, not because some news 
     organization had to make a big stink about it just to make a vendor
     take notice.

     Right now, people seem to think that big news media warnings on 
     cnet.com about SP2 fixing 15 vulnerabilities or similar is the proper
     way to get people to upgrade. That just -cannot- be right.

 (b) reporting a bug openly is _good_, and not frowned upon (right now 
     people clearly try to steer even white-hat people who have no real
     incentive to use vendor-sec into that mentality - because it's the
     "proper channel")

And yes, for this to work people need to get away from the notion of 
"let's apply vendor patch X to fix problem Y". What we should strive for 
(and what the whole system should be _geared_ for) is to have redundant 
enough security that people hopefully don't know of <n> outstanding bugs 
at the same time that allows for a combination attack. 

I'm convinced most security firms are like the virus firms: they react.  
They react to things they see on the cracker lists etc. They use a lot of
the same tools to find problems that really bad people find. That means
that the problems they "discover" are often discovered by the bad guys
first.  Sure, they have their own people too, but that's like saying that
_we_ have our own people too.

And that makes the whole "nondisclosure to avoid bad people" argument
pretty much totally bogus, something that nobody who argues for vendor-sec
seems to be willing to accept.

And let's not kid ourselves: the security firms may have resources that 
they put into it, but the worst-case schenario is actual criminal intent. 
People who really have resources to study security problems, and who have 
_no_ advantage of using vendor-sec at all. And in that case, vendor-sec is 
_REALLY_ a huge mistake. 

			Linus
