Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266976AbUBRByb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266989AbUBRByb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:54:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36057 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266967AbUBRBy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:54:27 -0500
Date: Wed, 18 Feb 2004 01:54:23 +0000
From: Matthew Wilcox <willy@debian.org>
To: davidm@hpl.hp.com
Cc: torvalds@osdl.org, Michel D?nzer <michel@daenzer.net>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
Message-ID: <20040218015423.GH11824@parcelfarce.linux.theplanet.co.uk>
References: <16434.35199.597235.894615@napali.hpl.hp.com> <1077054385.2714.72.camel@thor.asgaard.local> <16434.36137.623311.751484@napali.hpl.hp.com> <1077055209.2712.80.camel@thor.asgaard.local> <16434.37025.840577.826949@napali.hpl.hp.com> <1077058106.2713.88.camel@thor.asgaard.local> <16434.41884.249541.156083@napali.hpl.hp.com> <20040217234848.GB22534@krispykreme> <16434.46860.429861.157242@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16434.46860.429861.157242@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 04:51:24PM -0800, David Mosberger wrote:
> >>>>> On Wed, 18 Feb 2004 10:48:49 +1100, Anton Blanchard <anton@samba.org> said:
> 
>   Anton> A small thing, could the comment be constrained to 80
>   Anton> columns? :)
> 
> I don't really see the point of that, given that pretty much all
> existing Linux source code is formatted for 100 columns.  I don't feel
> strongly about it, however, so I changed it.

Um, only your crap.  Everybody else follows Documentation/CodingStyle.
This is mentioned in a couple of places:

Now, some people will claim that having 8-character indentations makes
the code move too far to the right, and makes it hard to read on a
80-character terminal screen.  The answer to that is that if you need
more than 3 levels of indentation, you're screwed anyway, and should fix
your program. 

...

Functions should be short and sweet, and do just one thing.  They should
fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
as we all know), and do one thing and do that well. 


I wish the ia64 code weren't indented to 100 columns.  It's why I hate
working with your code.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
