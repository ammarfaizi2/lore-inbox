Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSCRWWi>; Mon, 18 Mar 2002 17:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCRWW3>; Mon, 18 Mar 2002 17:22:29 -0500
Received: from mons.uio.no ([129.240.130.14]:4597 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S293092AbSCRWWO>;
	Mon, 18 Mar 2002 17:22:14 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
In-Reply-To: <E16lej0-0002FE-00@the-village.bc.nu>
	<Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu>
	<20020318192502.GD194@elf.ucw.cz>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Mar 2002 23:18:07 +0100
Message-ID: <shs1yeha5b4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pavel Machek <pavel@suse.cz> writes:

    >> * NFS (v2,v3): Portable.  And that's the only good thing to say
    >> about it - it's stateless, it has messy semantics all over the
    >> place and implementing userland server requires a lot of glue.

     > Does not work... If you mount nfs server on localhost, you can
     > deadlock.

Huh? Examples please? A hell of a lot of work has gone into ensuring
that this cannot happen. I do most of my NFS client work on this sort
of setup, so it had bloody well better work...

Cheers,
  Trond
