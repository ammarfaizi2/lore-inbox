Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSDEBEU>; Thu, 4 Apr 2002 20:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSDEBEA>; Thu, 4 Apr 2002 20:04:00 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:59144 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S310224AbSDEBDt>;
	Thu, 4 Apr 2002 20:03:49 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200204050103.g3513k3334779@saturn.cs.uml.edu>
Subject: Re: A modest proposal -- We need a patch penguin
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Thu, 4 Apr 2002 20:03:46 -0500 (EST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        lm@bitmover.com (Larry McVoy)
In-Reply-To: <E16Vs31-0000DU-00@starship.berlin> from "Daniel Phillips" at Jan 30, 2002 11:32:59 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On January 30, 2002 10:33 am, Linus Torvalds wrote:

>> I still dislike some things (those SHOUTING SCCS files) in bk, and let's
>> be honest: I've used CVS, but I've never really used BK. Larry has given
>> me the demos, and I actually decided to re-do the examples, but it takes
>> time and effort to get used to new tools, and I'm a bit worried that
>> I'll find other things to hate than just those loud filenames.
>
> Oh gosh, I hate those too.  (Yes, this is a "me too".)  Larry, could we 
> *please* have that metadata in a .file?

Try "man ls":

       -I, --ignore=PATTERN
              do not list implied entries matching shell PATTERN


So then something like this...

alias ls='/bin/ls --ignore=SCCS'
