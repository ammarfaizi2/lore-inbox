Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSHVXXy>; Thu, 22 Aug 2002 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSHVXXy>; Thu, 22 Aug 2002 19:23:54 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:10493 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318113AbSHVXXx>; Thu, 22 Aug 2002 19:23:53 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.29561.439324.940222@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 09:27:53 +1000
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: New large block-device patch for 2.5.31+bk
In-Reply-To: <967473057@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:


Christoph> I don't have much comments left :) What about moving the
Christoph> sector_t typedef completly to <asm/types.h>?  Looks like
Christoph> the cleanest solution to me.

I'd rather not, because most of the architectures just need the
generic version.  I *hate* unnecessarily duplicated code.

Christoph> I also wonder whether CONFIG_LBD might want to move to
Christoph> arch/*/config.

I thought about that, but couldn't work out any way to make it appear
in the right place in the menus --- it's really a block device
configuration option that happens to be needed only for a few
architectures.

Christoph> An a little suggestion: you could feed that patch to Linus
Christoph> in pieces.  The printk cleanups might be a good start.

Will do...


--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
