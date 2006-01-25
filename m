Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWAYWk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWAYWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAYWk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:40:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932193AbWAYWkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:40:23 -0500
Date: Wed, 25 Jan 2006 17:39:16 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chase Venters <chase.venters@clientec.com>
cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
Message-ID: <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Jan 2006, Chase Venters wrote:
> 
> This means that when the code went GPL v1 -> GPL v2, the transition was
> permissible. Linux v1.0 shipped with the GPL v2. It did not ship with a
> separate clause specifying that "You may only use *this* version of the GPL"
> as it now does. (I haven't done any research to find out when this clause was
> added, but it was after the transition to v2).

Bzzt. Look closer.

The Linux kernel has _always_ been under the GPL v2. Nothing else has ever 
been valid.

The "version 2 of the License, or (at your option) any later version" 
language in the GPL copying file is not - and has never been - part of the 
actual License itself. It's part of the _explanatory_ text that talks 
about how to apply the license to your program, and it says that _if_ you 
want to accept any later versions of the GPL, you can state so in your 
source code.

The Linux kernel has never stated that in general. Some authors have 
chosen to use the suggested FSF boilerplate (including the "any later 
version" language), but the kernel in general never has.

In other words: the _default_ license strategy is always just the 
particular version of the GPL that accompanies a project. If you want to 
license a program under _any_ later version of the GPL, you have to state 
so explicitly. Linux never did.

So: the extra blurb at the top of the COPYING file in the kernel source 
tree was added not to _change_ the license, but to _clarify_ these points 
so that there wouldn't be any confusion. 

The Linux kernel is under the GPL version 2. Not anything else. Some 
individual files are licenceable under v3, but not the kernel in general. 

And quite frankly, I don't see that changing. I think it's insane to 
require people to make their private signing keys available, for example. 
I wouldn't do it. So I don't think the GPL v3 conversion is going to 
happen for the kernel, since I personally don't want to convert any of my 
code. 

> If a migration to v3 were to occur, the only potential hairball I see is if
> someone objected on the grounds that they contributed code to a version of the
> kernel Linus had marked as "GPLv2 Only". IANAL.

No. You think "v2 or later" is the default. It's not. The _default_ is to 
not allow conversion.

Conversion isn't going to happen.

		Linus
