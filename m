Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTCQUch>; Mon, 17 Mar 2003 15:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbTCQUcg>; Mon, 17 Mar 2003 15:32:36 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:53850 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S261934AbTCQUcg>;
	Mon, 17 Mar 2003 15:32:36 -0500
Date: Mon, 17 Mar 2003 21:43:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Daniel Phillips <phillips@arcor.de>,
       Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
       Nicolas Pitre <nico@cam.org>, Ben Collins <bcollins@debian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317204331.GI1324@dualathlon.random>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <Pine.LNX.4.44.0303170104080.5042-100000@serv> <20030317013555.GA26273@work.bitmover.com> <20030317174304.EC6FC3D268@mx01.nexgo.de> <20030317180432.GD9667@gtf.org> <20030317193209.GA11881@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317193209.GA11881@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 07:32:09PM +0000, Jamie Lokier wrote:
> I still don't understand why bkbits.net does not simply make the SCCS
> files available.
> 
> That would render every objection moot.

tell me how to get the data and metadata out of the SCCS files for
changeset 1.786.202.5 like in the below:

	http://linux.bkbits.net:8080/linux-2.5/user=akpm/patch@1.786.202.5?nav=!-|index.html|stats|!+|index.html|ChangeSet@-6M|cset@1.786.202.5

then tell me how to find the number "1.786.202.5" watching the SCCS
history of kernel/timer.c.

SCCS provides per-file info, not the global metadata of the tree. That
other information is stored in a proprietary format that the bitbucket
project is trying to parse. CVS exports the whole info in a open format,
this is why it's so much better than trying to parse the proprietary
format that can be changed anyways to compressed and maybe encrypted
format too.

Andrea
