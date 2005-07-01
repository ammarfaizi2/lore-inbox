Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVGAU3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVGAU3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGAU3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:29:17 -0400
Received: from ucsd-exchange.ucsd.edu ([132.239.1.171]:24527 "EHLO
	ono-exchange.ad.ucsd.edu") by vger.kernel.org with ESMTP
	id S261579AbVGAU0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:26:33 -0400
Subject: Re: reiser4 plugins
From: Kevin Bowen <kevin@ucsd.edu>
To: Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42C4E903.4070206@slaphack.com>
References: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
	 <42C4E903.4070206@slaphack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Jul 2005 13:26:31 -0700
Message-Id: <1120249592.22241.84.camel@punchline.ucsd.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Could you please explain in plain english? The only part I get out is
> > "propietary API", and I don't see anybody advocating such here.

Proprietary was a poor choice of words on my part.

> I don't understand it much, but I think the point being made is that 
...
> So, for instance, if I want to grab all mp3s with Artist "Paul 
> Oakenfold" and change the genre to "techno" (can you do that?), I can 
> use Beagle's search tool to find all mp3s by Oakenfold, but to change 
> the genre, I have to use some separate tool to manipulate id3 tags, 

Yes, this is basically what I was getting at, although I was thinking
more in terms of the reiser5/6/whatever set theoretic semantics, which,
from my point of view at least, reiser4 is simply the first step towards
building the enabling infrastructure of. But the fact that reiser4
semantics + trivial shell scripting enables, as illustrated by David,
the rough equivalent of set-theoretic semantics, demonstrates how
reiser4 is in fact a step in this direction.

> > moment the case of system-wide or network-wide shared data,
> I.e., something like 90% of the use of Linux here. OK.

90% of *what* exactly? 90% of what machines deal with, or 90% of what
humans interact with?

> > users needs. In fact, I believe there is currently a JSR in 
> > progress to develop a more sophisticated Java packaging model.
>
> Presumably based on ReiserFS 4, which then has to be ported to 
> whatever platform you want to run Java on ASAP? Great for you! Wait a
> bit, and you'll get what you want then, even across the board!
 
No, obviously that's not what I was saying. But the need for these kinds
of domain-specific packaging/metadata formats, each requiring their own
tools to work with, would be alleviated if there were simply a more
powerful filesystem semantic. Clearly forcing reiser on the world is a
non-starter, but try extending your imagination a little bit to a future
in which there's a 'new POSIX' specifying a set-theoretic filesystem
model. So-called 'database-filesystems' ARE coming, whether from
Microsoft, Apple, or us. Who gets there first will determine who gets to
make the rules.


-- 
kevin@ucsd.edu
