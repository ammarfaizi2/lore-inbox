Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264718AbSKDQRM>; Mon, 4 Nov 2002 11:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKDQRM>; Mon, 4 Nov 2002 11:17:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1541 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264718AbSKDQRK>; Mon, 4 Nov 2002 11:17:10 -0500
Date: Mon, 4 Nov 2002 08:22:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard J Moore <richardj_moore@uk.ibm.com>
cc: Oliver Xymoron <oxymoron@waste.org>, Dave Anderson <anderson@redhat.com>,
       <linux-kernel@vger.kernel.org>, <lkcd-devel@lists.sourceforge.net>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-general-admin@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
Message-ID: <Pine.LNX.4.44.0211040727330.771-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Nov 2002, Richard J Moore wrote:
> 
> Are you sure? Isn't what Linus is saying is that he understands that some
> problems can be solved using dumps, some from the oops message and some by
> source code inspection and some by others means. But, he's not interested
> in a timely resolution;

Ok, with tons of explanation:

 - I'm clearly not interested. I've not seen any discussion of the usage 
   of the tools or how great it is, and that's apparently because all the
   LKCD people are off in their own mailing lists and do not want to have
   anything to do with the rest of the world. Except when they come out of
   the blue one week before feature freeze and _demand_ that I accept
   their patches that I've never seen before or heard anybody talk about.

   Hint: think about this part. Deeply. And then go and bother SOMEBODY 
   ELSE.

 - Since I'm not personally convinced, it's not going into my tree.

   It's as simple as that. I take stuff that I feel is good. Often that 
   feeling of goodness comes from trusting the person who sends it to me, 
   simply by past performance.  At other times, it is because I think the 
   feature is cool, or well done, or whatever.

   Hint: if you want stuff in my tree, make me trust you. Or work on 
   things that I feel are innately interesting. Don't bother dragging me 
   into your flame-wars and trying to convince me that I "must" apply your
   patches.

 - If it doesn't go into my tree, is that bad?

   NO! Open source is all about _other_ people being able to make their 
   changes. It by no means means that those changes have to be accepted 
   back: the license basically only boils down to that I must be _able_ to
   accept them back. But the really important thing, the thing that really 
   makes a difference, is that you, your dog, and your company can make
   your OWN changes.

 - If it doesn't have to happen in my tree, then whose tree _does_ it have 
   to happen in?  

   Doesn't much matter, actually. You can keep it in your tree, for all I 
   care. OSDL has already picked it up and apparently maintains it in 
   their tree. The only thing that matters is whether it gets used or not, 
   and whether it proves itself.

   More people use vendor trees than my tree. And if you don't find a 
   vendor who will apply your patches, there are several "personal 
   vendors" out there, with the -ac, -aa and -mm trees being the obvious
   ones. Many of those trees are not just used, they are also 
   obviously backed by people I do trust, which brings us back to the
   criteria for _me_ to apply patches.

 - Considering the above, if you still want it to _eventually_ make it 
   into my tree, what should you do?

   Do you think pestering me makes me like the patches any more and trust 
   you? And if it doesn't, then how do you expect it to help, considering 
   my patch acceptance criteria?

   No. The way to get it into my tree is not to whine about it. There are 
   a few different ways to get it into my tree:

	(a) prove me wrong. And btw, it doesn't help to do so in your LKCD 
	    mailing list. You need to get those patches out there to 
	    _other_ people, or convince your own people that living in 
	    your little hole just means that nobody else knows or cares 
	    about you.

	(b) If you can't convince me, convince somebody else. Maybe that 
	    somebody else is somebody I trust, and that somebody else 
	    feels that I was wrong and since _he_ believes in the project 
	    he will try to convince me about it.

	    And trust me, the people I trust don't revere me and think I'm 
	    always right. These people call me "pinhead" and tell me when
	    I'm full of shit. If these people don't believe in your
	    project, don't blame me and think it's because I "poisoned 
	    their minds". 

	(c) Push your vendor. I have absolutely _zero_ incentives to care 
	    about whining users (I care deeply about the non-whining 
	    kind), but vendors do. Sometimes they do things just to get 
	    their users off their backs.

	    And once it's in a vendor tree, that doesn't guarantee I pick 
	    it up, but it _does_ guarantee that the patch is at least
	    widely used and thus we get more easily to (a) - proving me 
	    wrong outside your own little world.

 - Never whine about a patch. I know whining works with a lot of people
   ("Oh, for chrissake, I'll just do it to get him off my back") but it 
   works remarkably badly with me. Trust me on this.

Was this clear enough? Any confusion on any particular issue? 

In short: convince somebody else. So far, the only thing that the 
discussion has convinced me off is that people somehow seem to think that 
they are ENTITLED to being merged into my tree. Tough. It ain't so. That 
tree is called "Linus' tree" for a reason.  The only thing you are 
ENTITLED to is to have your own tree.

		Linus

