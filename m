Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSCSXoz>; Tue, 19 Mar 2002 18:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310825AbSCSXop>; Tue, 19 Mar 2002 18:44:45 -0500
Received: from bitmover.com ([192.132.92.2]:32996 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310816AbSCSXoh>;
	Tue, 19 Mar 2002 18:44:37 -0500
Date: Tue, 19 Mar 2002 15:44:36 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, pavel@suse.cz, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319154436.N14877@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, lm@bitmover.com,
	pavel@suse.cz, davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020319002241.K17410@suse.de> <20020319220631.GA1758@elf.ucw.cz> <20020319152502.J14877@work.bitmover.com> <20020319.152759.06816290.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 03:27:59PM -0800, David S. Miller wrote:
>    From: Larry McVoy <lm@bitmover.com>
>    Date: Tue, 19 Mar 2002 15:25:02 -0800
> 
>    Come on Pavel, in order to make this happen, you have to
>    
>    	a) run the installer as root
>    	b) know the next pid which will be allocated
>    	c) put the symlink in /tmp/installer$pid
>    
> Exploit: Make all 65535 $pid simlinks
> 
> It's very exploitable actually, and is similar in vein to
> all the ancient mktemp stuff.

Hey Dave, are you suggesting that no such exploits exist in Red Hat's 
rpm system?  In order for that to be true, rpm would have to be making
sure that each and every directory along any path that it writes is
not writable except by priviledged users.  I just checked, it doesn't.

We can sit here all day and make a big deal out of this, I think it's a
waste of time.  I'm not an advocate of insecure software and I'm happy
to close any holes that people think need closing, but you're just
wasting time.  This isn't an issue.  If you really, really cared, there
is nothing to prevent you from downloading the BK image, unpacking it on
a throwaway machine, back it back up again in a shar file or whatever,
and then installing it.

At some point, people get to take responsibility for their own choices.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
