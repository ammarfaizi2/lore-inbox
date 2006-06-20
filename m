Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965321AbWFTDPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965321AbWFTDPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWFTDPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:15:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965314AbWFTDPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:15:18 -0400
Date: Mon, 19 Jun 2006 20:14:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
In-Reply-To: <20060620025552.GO27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
 <20060620025552.GO27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, Al Viro wrote:
> 
> Hrm...  That's actually one thing git might do - how hard would it be
> to teach git-upload-pack to generate the diffstat and shortlog instead
> of a pack?  It has all information needed for that, after all...

It _does_ do that.  When I do a pull, it shows me what got pulled, and if 
I don't like it, I can just undo it.

But that's not the point.

I want to know what I'm pulling _ahead_ of time, AND I WANT TO KNOW THAT 
WHAT I PULL IS WHAT THE SENDER INTENDED ME TO PULL!

No amount of "git tells me what I pulled" will ever give me either.

If the pushing side cannot be bothered to tell me what the repository 
contains, I really don't want to have anything to do with that repository 
or its maintainer. I want people to tell me what they are sending me, 
because that way both they and I are aware of what to expect.

In other words, this is not about technology. This is about human 
interaction. I do _not_ trust git repositories. I trust the people who 
make those git repositories available, and that means that I want to hear 
from them.

I want them to tell me what they are sending, so that _when_ I pull, I can 
line up the result of that pull with the mail they sent, and I can tell 
"ok, that's actually what the other side intended".

		Linus
