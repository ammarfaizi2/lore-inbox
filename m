Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271228AbTG2ChQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271229AbTG2ChQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:37:16 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:7073 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271228AbTG2ChL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:37:11 -0400
To: Bernardo Innocenti <bernie@develer.com>
Cc: Nicolas Pitre <nico@cam.org>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.6 size increase
References: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>
	<200307290102.01313.bernie@develer.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 29 Jul 2003 11:36:01 +0900
In-Reply-To: <200307290102.01313.bernie@develer.com>
Message-ID: <buoispmhxf2.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> writes:
> > Being able to remove the block layer entirely, just as for the networking
> > layer, should be considered too, since none of ramfs, tmpfs, nfs, smbfs,
> > jffs and jffs2 just to name those ones actually need the block layer to
> > operate.  This is really a big pile of dead code in many embedded setups.
> 
> It's a great idea.

Yup.

When I've used a debugger to trace through the kernel reading a block on
a system using only romfs, it's utterly amazing how much completely
unnecessary stuff happens.

Of course it's a lot harder to find a clean way to make it optional
than it is to complain about it ... :-)

-Miles
-- 
I have seen the enemy, and he is us.  -- Pogo
