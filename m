Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284301AbRL1X0I>; Fri, 28 Dec 2001 18:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284360AbRL1X0A>; Fri, 28 Dec 2001 18:26:00 -0500
Received: from mail012.syd.optusnet.com.au ([203.2.75.172]:18857 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S284445AbRL1XZm>; Fri, 28 Dec 2001 18:25:42 -0500
Date: Sat, 29 Dec 2001 10:25:38 +1100
Mime-Version: 1.0 (Apple Message framework v480)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: State of the new config & build system
From: Stewart Smith <stewart@softhome.net>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Message-Id: <33D0FE78-FBEA-11D5-880A-00039350C45A@softhome.net>
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dammit, didn't hit "reply all" grr....

On Saturday, December 29, 2001, at 05:02  AM, Linus Torvalds wrote:

<snip>
> My pet peeve is "centralized knowledge". I absolutely detested the first
> versions of cml2 for having a single config file, and quite frankly I
> don't think Eric has even _yet_ separated things out enough - why does 
> the
> main "rules.cml" file have architecture-specific info, for example?

agreed - it's something that really irritates me too. As Linux is 
running on so many different architectures (some of which are purely 
virtual, such as Usermode Linux and my whacky idea of running it ontop 
of MacOS X) so it seems that keeping all the options for architectures 
separate would make a lot of sense. I've never seen a cross-platform 
binary kernel (although have had scary dreams of one)

<snip>
> So if somebody really wants to help this, make scripts that generate
> config files AND Configure.help files from a distributed set. And once 
> you
> do that, you could even imagine creating the old-style config files
> (without the automatic checking and losing some information) from the
> information.


This shouldn't be too hard should it? In each module directory have a 
config and Configure.help file, then just

find . |grep config

and then cat all the files together. If I have some spare time today 
I'll see if I can hack something up.... :)

------------------------------
Stewart Smith
stewart@softhome.net
Ph: +61 4 3884 4332
ICQ: 6734154

