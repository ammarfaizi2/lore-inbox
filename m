Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310447AbSCPRRd>; Sat, 16 Mar 2002 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310451AbSCPRRX>; Sat, 16 Mar 2002 12:17:23 -0500
Received: from host194.steeleye.com ([216.33.1.194]:21002 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310447AbSCPRRG>; Sat, 16 Mar 2002 12:17:06 -0500
Message-Id: <200203161717.g2GHH1K20221@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Larry McVoy <lm@bitmover.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository. 
In-Reply-To: Message from Larry McVoy <lm@bitmover.com> 
   of "Sat, 16 Mar 2002 08:52:13 PST." <20020316085213.B10086@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 12:17:01 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lm@bitmover.com said:
> If you get into a duplicate patch situation, you are far better off to
>  pick one tree or the other tree as the official tree, and cherrypick
> the changes that the unofficial tree has and place them in the
> official tree.  Then toss the unofficial tree.  I can make you a "bk
> portpatch" command which does this, we have that already, it needs a
> bit of updating to catch the comments. 

That's essentially what I had to write to move my trees over, so an official 
one would be extremely useful.  I do have the piece which catches the comments 
if you want it.

jgarzik@mandrakesoft.com said:
> So, knowing that duplicate patches are a bad thing helps not in the
> least here... 

If bitkeeper had a way of replacing duplicate patches, this would be extremely 
useful.  All I really needed to do was replace the keys in the changelog from 
the garzik tree with the mareclo one to get my changes moved over.  I think 
essentially this could be done with a bk send|bk receive as long as I can tell 
bitkeeper that it needs a substitute set of keys when applying the bkpatch.

James


