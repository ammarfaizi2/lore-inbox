Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263934AbRFHJNj>; Fri, 8 Jun 2001 05:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263935AbRFHJN3>; Fri, 8 Jun 2001 05:13:29 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:48901 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S263934AbRFHJNV>;
	Fri, 8 Jun 2001 05:13:21 -0400
Date: Fri, 8 Jun 2001 11:12:55 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help i18n system
Message-ID: <20010608111255.A5606@se1.cogenit.fr>
In-Reply-To: <UTC200106072146.XAA217951.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200106072146.XAA217951.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Jun 07, 2001 at 11:46:20PM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl <Andries.Brouwer@cwi.nl> ecrit :
[...]
> (i) The kernel has high visibility, and work on the kernel
> [even if only on the Documentation subdirectory] has high "prestige".
> As a consequence, parts of the kernel tree are kept much better
> up-to-date than documentation found elsewhere.

Why would quality be lowered if instead of trying and push a Configure.help 
patch to an already busy Linus, one should notify the maintainer ?
Simply because it doesn't gain the same "prestige" to the author ?
*big pain*

I don't forget your proc.5/bootparam.7 argument but it's not the same
point imho.

[...]
> (ii) So far, building a kernel involved getting a single tarball.
> If the help for over a thousand configuration options is found
> a hundred different places on the net, of which five are currently
> unreachable, things get really cumbersome.

Not everybody reads a thousand configuration options entry.
If I want a kernel tailored for a specific machine, I keep a .config
somewhere, make oldconfig and so on. I don't read a Configure.help
entry that hasn't changed for months. Documentation/Changes is enough.
If I want to build the usual "does everything compile?" kernel, the
Configure.help entry isn't that needed.
If it's the first time I compile a kernel, $DISTRIBUTION could include 
the extra package somewhere. Outdated ? We aren't talking about people 
working with testing versions thus I doubt it's really a problem.

> The current system is not so bad.

Yes. However, the point of "Configure.help doesn't belong to core"
makes sense (as long as it doesn't prevent compile).

--
Ueimor
