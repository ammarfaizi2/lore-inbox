Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTBEX71>; Wed, 5 Feb 2003 18:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBEX71>; Wed, 5 Feb 2003 18:59:27 -0500
Received: from bitmover.com ([192.132.92.2]:60090 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265198AbTBEX70>;
	Wed, 5 Feb 2003 18:59:26 -0500
Date: Wed, 5 Feb 2003 16:08:58 -0800
From: Larry McVoy <lm@bitmover.com>
To: Mitch Adair <mitch@theneteffect.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030206000858.GC21064@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mitch Adair <mitch@theneteffect.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030205235126.GA21064@work.bitmover.com> <200302060002.SAA28514@mako.theneteffect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302060002.SAA28514@mako.theneteffect.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "I will let someone know so they can fix it.  Shazam!"

Hmm, while I think that glibc should be fixed my general response is that
you shouldn't be running a statically linked version, which is probably
the cause of the guy's problems.  Both our experience and lots of user
experience is that if you run the glibc2.2 version on a glibc2.3 system
it works fine.

The only reason we made a statically linked version available was for
Richard Gooch who insisted on maintaining his own a.out based distro.
I haven't heard from him in months so I'll nuke that image and maybe
the problem is gone.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
