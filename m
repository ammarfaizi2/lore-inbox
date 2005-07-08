Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVGHQj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVGHQj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVGHQj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:39:58 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:1777 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262707AbVGHQj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:39:57 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Hans Reiser <reiser@namesys.com>
Cc: "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42CCCEEA.7040302@namesys.com> (Hans Reiser's message of "Wed,
 06 Jul 2005 23:42:50 -0700")
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>
	<87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>
	<1120675943.13341.10.camel@localhost> <42CCCEEA.7040302@namesys.com>
X-Hashcash: 1:23:050708:reiser@namesys.com::NvboBTW6m1I0oYLw:0000000000000000000000000000000000000000000Qmpu
X-Hashcash: 1:23:050708:agmsmith@rogers.com::esA0B4kX13mw0t+Q:000000000000000000000000000000000000000000wECa
X-Hashcash: 1:23:050708:ross.biro@gmail.com::xFvKouWhZkaWTYrF:0000000000000000000000000000000000000000004r74
X-Hashcash: 1:23:050708:vonbrand@inf.utfsm.cl::Z7PXoPgQ4hFyDkt0:0000000000000000000000000000000000000000B927
X-Hashcash: 1:23:050708:mrmacman_g4@mac.com::hSxuDNB7pCQD8oCf:000000000000000000000000000000000000000000bJLN
X-Hashcash: 1:23:050708:valdis.kletnieks@vt.edu::x+WACdexC6vp/w6a:00000000000000000000000000000000000000ibaG
X-Hashcash: 1:23:050708:ltd@cisco.com::pWZSt3bLwMmKlhnu:0000DXj6
X-Hashcash: 1:23:050708:gmaxwell@gmail.com::FoC+AVIBXvj0T6tR:0000000000000000000000000000000000000000000ovIo
X-Hashcash: 1:23:050708:jgarzik@pobox.com::fqONaEWnQOuLuabG:00000000000000000000000000000000000000000000W3hM
X-Hashcash: 1:23:050708:hch@infradead.org::ttW8INOkQ6Tcsr/W:00000000000000000000000000000000000000000000cCVz
X-Hashcash: 1:23:050708:akpm@osdl.org::Es6IVIVOMJ+tkeV/:000042gE
X-Hashcash: 1:23:050708:linux-kernel@vger.kernel.org::R9pWmuXCxNC3JWjJ:00000000000000000000000000000000038Qv
X-Hashcash: 1:23:050708:reiserfs-list@namesys.com::ARw75ttKkj2FSIgF:000000000000000000000000000000000000I1If
X-Hashcash: 1:23:050708:zam@namesys.com::+57VXSvHVopT95uB:00PtcH
X-Hashcash: 1:23:050708:vs@thebsh.namesys.com::qMym1S/d0XNK1c9e:0000000000000000000000000000000000000000QjwQ
X-Hashcash: 1:23:050708:ndiller@namesys.com::RZZUOdQrHFF8rF4c:000000000000000000000000000000000000000000qV1y
X-Hashcash: 1:23:050708:ninja@slaphack.com::d69bjLd8CnVcEWvP:0000000000000000000000000000000000000000000xf/w
X-Hashcash: 1:23:050708:vitaly@thebsh.namesys.com::+KG7HnfmPXe1osEK:000000000000000000000000000000000000YaQt
Date: Fri, 08 Jul 2005 12:39:31 -0400
Message-ID: <87oe9duu9o.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Fri, 08 Jul 2005 12:39:48 -0400 (EDT)
X-Miltered: at aeacus with ID 42CEAC72.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 23:42:50 -0700, Hans Reiser <reiser@namesys.com> said:

> Oh no, don't store the whole path, store just the parent list.  This
> will make fsck more robust in the event that the directory gets
> clobbered by hardware error.

> I don't think it affects the cost of detecting cycles though, I think
> it only makes fsck more robust.

It doesn't affect the worst-case cost of detecting cycles; by necessity,
any (static [1]) directed cycle detection algorithm must take O(n) time,
n being the size of the tree (nodes + links).  However, under
"reasonable assumptions" (where the reasonableness of those assumptions
may be questioned, but I think they're reasonable), I think that doing a
depth-first-search through the parent links makes the algorithm
not-too-terrible.  Namely, the "reasonable assumptions" are that a node
doesn't have "too many" parents, and the filesystem hierarchy is not
"too deep".

[1] BTW, I had also previously looked at online/dynamic algorithms, for
those who are familiar with that area.  The best known so far is still
O(n) worst case, but much, much smaller in "most cases".

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

