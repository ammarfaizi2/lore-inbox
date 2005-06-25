Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFYX4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFYX4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 19:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFYX4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 19:56:31 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:9130 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261222AbVFYXzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 19:55:44 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Hans Reiser <reiser@namesys.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Mahoney <jeffm@suse.de>, penberg@gmail.com, ak@suse.de,
       flx@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42BDAF3D.6060809@namesys.com> (Hans Reiser's message of "Sat,
 25 Jun 2005 12:23:41 -0700")
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	<p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
	<20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
	<84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de>
	<20050623114318.5ae13514.akpm@osdl.org>
	<20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost>
	<42BDAF3D.6060809@namesys.com>
X-Hashcash: 1:23:050625:reiser@namesys.com::jbBSAmsAh4yl2xIN:0000000000000000000000000000000000000000001CF5Z
X-Hashcash: 1:23:050625:axboe@suse.de::1nMOt956nrC3Vc79:0000BdRs
X-Hashcash: 1:23:050625:akpm@osdl.org::l08qywD6n08XeCWC:0000RfxU
X-Hashcash: 1:23:050625:jeffm@suse.de::5cIxjqf338FAdu1m:00003sJ+
X-Hashcash: 1:23:050625:penberg@gmail.com::imgWHZyshD4kGvc2:00000000000000000000000000000000000000000000B/Xa
X-Hashcash: 1:23:050625:ak@suse.de::N6rIpCYt+ZioDZ8f:0000000U4vD
X-Hashcash: 1:23:050625:flx@namesys.com::IB3OUxPZL/l8K7LZ:00BO9y
X-Hashcash: 1:23:050625:zam@namesys.com::jk+aB5rvJ07DVYyc:00PCfV
X-Hashcash: 1:23:050625:vs@thebsh.namesys.com::Dk3O1Lqoc+hb9gBo:0000000000000000000000000000000000000000BgFB
X-Hashcash: 1:23:050625:linux-kernel@vger.kernel.org::MOpdMaGeep9pTi3b:000000000000000000000000000000000Hrox
X-Hashcash: 1:23:050625:reiserfs-list@namesys.com::E2wRbjIKXm+Wsuwc:0000000000000000000000000000000000001B9f
Date: Sat, 25 Jun 2005 19:54:52 -0400
Message-ID: <87slz6f0vn.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at minos with ID 42BDED34.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2005 12:23:41 -0700, Hans Reiser <reiser@namesys.com> said:

>>> assert("trace_hash-89", is_hashed(foo) != 0);

> Lots of people like corporate anonymity.  Some don't.  I don't.  I
> like knowing who wrote what. ...

For what it's worth (I know: not much), I like the named asserts in
Reiser4/Reiserfs.  Although I haven't been bitten by any BUGs yet (maybe
I'm just lucky), whenever I see these on the mailing list, it gives the
impression that the users are interacting more directly with the
developers, and it helps us to get to know the developers better.

If people really want more standard-looking identifiers, I think Namesys
should keep the names and make a hybrid identifier, like
"nikita-123(<file>:<line>)"

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

