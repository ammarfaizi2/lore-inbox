Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264569AbRFOXm3>; Fri, 15 Jun 2001 19:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264570AbRFOXmT>; Fri, 15 Jun 2001 19:42:19 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4613 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264569AbRFOXmI>; Fri, 15 Jun 2001 19:42:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        phillips@bonn-fries.net (Daniel Phillips)
Subject: Re: [patch] nonblinking VGA block cursor
Date: Sat, 16 Jun 2001 01:44:40 +0200
X-Mailer: KMail [version 1.2]
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), ljb@devco.net (Leon Breedt),
        linux-kernel@vger.kernel.org
In-Reply-To: <200106151938.f5FJcIJ288693@saturn.cs.uml.edu>
In-Reply-To: <200106151938.f5FJcIJ288693@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <0106160144400D.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 June 2001 21:38, Albert D. Cahalan wrote:
> Daniel Phillips writes:
> > On Friday 15 June 2001 21:21, Albert D. Cahalan wrote:
> >> Non-blinking cursors are just wrong. You need to patch your brain.
> >> You really fucked up, because now apps can't restore your cursor
> >> to proper behavior as defined by IBM.
> >
> > Just one question Albert: why doesn't my mouse cursor blink? ;-)
>
> 1. confusion with the text cursor, which should blink
> 2. need for continuous pixel-to-pixel accuracy with the mouse
> 3. you can wiggle your mouse as needed to find the mouse cursor

4. It would be bloody annoying.

Some people find the blinking text cursor equally annoying, you appear to be 
trying to dictate what their options should be.

> Apps do funny things when you try to wiggle the text cursor
> with the arrow keys, and movement tends to be harshly constrained.
> So the blinking is important.

Ask the original poster if he's willing to take the risk of going with an xor 
cursor.  We are talking text mode, right?  No way to get rid of that blinking 
text cursor, ever.  Tell me, do you like having the colon blink on your alarm 
clock too?  Personally, I opened the thing up and put a piece of tape over it.

As I recall, one of the popular projects when the IBM PC first came out was 
trying to get the cursor to stop blinking.  No luck, IBM had hardwired in a
special trace to make sure you couldn't.  You could or two blink patterns 
together, but never get it to stop.  Since we are now in a position to 
dictate, why don't we continue that grand tradition.

IBM had lots of ideas about how computers should work.  Remember the keyboard 
keys that when CLACK CLACK CLACK.  Thank god they turned out to be too 
expensive to clone - nobody misses them now.

When people ask for such options it's not because they want to make *your* 
cursor stop blinking, it's because they want *theirs* to stop.

--
Daniel
