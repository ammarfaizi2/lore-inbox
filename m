Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278541AbRJXO5n>; Wed, 24 Oct 2001 10:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278543AbRJXO5d>; Wed, 24 Oct 2001 10:57:33 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:7674 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278541AbRJXO5U>; Wed, 24 Oct 2001 10:57:20 -0400
Date: Wed, 24 Oct 2001 15:57:45 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Two suggestions (loop and owner's of linux tree)
In-Reply-To: <20011024143850.EAC2598410@oceanic.wsisiz.edu.pl>
Message-ID: <Pine.SOL.4.33.0110241554530.11667-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Lukasz Trabinski wrote:

> In article <1003933278.1496.6.camel@LNX.iNES.RO> you wrote:
> >> I would like to suggest to change max_loop from 8 to 16 or more if it
> >> possible.
>
> > max_loop=16 in your kernel command line if you use loop builtin or:
> > options loop max_loop=16 in /etc/modules.conf if you use it as an
> > module.
>
> I know about this option, but I think limit max=16 is much better.

I disagree: presumably increasing the limit takes resources, in which case
a fairly low default is best.

> > chmod -R root.root linux/

errr. chown perhaps? :)

> > after you have unpacked the tarball.
>
> Unnecessarily extra command :) Sometimes I can forget about this and then
> user with uid 1046 can modify my kernel source.

Just give UID 1046 to a new user, "linus" :)


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

