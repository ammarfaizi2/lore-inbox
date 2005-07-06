Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVGFVBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVGFVBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVGFU7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:59:03 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:65019 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262552AbVGFU5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:57:49 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Jonathan Briggs <jbriggs@esoft.com>
Cc: "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <1120681998.13341.23.camel@localhost> (Jonathan Briggs's
 message of "Wed, 06 Jul 2005 14:33:18 -0600")
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>
	<87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>
	<1120675943.13341.10.camel@localhost>
	<87mzozemqp.fsf@evinrude.uhoreg.ca>
	<1120681998.13341.23.camel@localhost>
X-Hashcash: 1:23:050706:jbriggs@esoft.com::UlD2Ne/2isDpwzDy:000000000000000000000000000000000000000000004BGo
X-Hashcash: 1:23:050706:agmsmith@rogers.com::RF4xSBgc6OnIByyR:000000000000000000000000000000000000000000CZnt
X-Hashcash: 1:23:050706:ross.biro@gmail.com::QqV5fhbqvaLNTO8/:000000000000000000000000000000000000000000KDaM
X-Hashcash: 1:23:050706:vonbrand@inf.utfsm.cl::VMwOYSB3SxnMYgrL:0000000000000000000000000000000000000000Xk3U
X-Hashcash: 1:23:050706:mrmacman_g4@mac.com::TYetx53Dap0F4Gzo:000000000000000000000000000000000000000000Z8jj
X-Hashcash: 1:23:050706:valdis.kletnieks@vt.edu::Ug6eKdJjbPoF9QiE:00000000000000000000000000000000000000DXfX
X-Hashcash: 1:23:050706:ltd@cisco.com::ySZ0YGCbiB8HZSAA:0001lGvz
X-Hashcash: 1:23:050706:gmaxwell@gmail.com::HfMnhcsl4/0NBj3L:0000000000000000000000000000000000000000000ACg9
X-Hashcash: 1:23:050706:jgarzik@pobox.com::ffNxFveAHQj3PJ3C:000000000000000000000000000000000000000000004a3I
X-Hashcash: 1:23:050706:hch@infradead.org::qAszGfj/JwmgdDZj:00000000000000000000000000000000000000000000K0NT
X-Hashcash: 1:23:050706:akpm@osdl.org::2wCEYL+JpTsLswp+:0000WuDf
X-Hashcash: 1:23:050706:linux-kernel@vger.kernel.org::OZennqajuXE7rn9c:000000000000000000000000000000000948/
X-Hashcash: 1:23:050706:reiserfs-list@namesys.com::ECNtJiUf2m+wSYDy:000000000000000000000000000000000002FcLV
X-Hashcash: 1:23:050706:zam@namesys.com::wwZ0lvVvyWv1vcxH:00RRGp
X-Hashcash: 1:23:050706:vs@thebsh.namesys.com::HzOfNADsPiNFREJs:0000000000000000000000000000000000000000FL0W
X-Hashcash: 1:23:050706:ndiller@namesys.com::St02+ByhQGpEhXUf:0000000000000000000000000000000000000000001NCI
X-Hashcash: 1:23:050706:ninja@slaphack.com::1CNyBch3A37XzUit:0000000000000000000000000000000000000000000/tE8
X-Hashcash: 1:23:050706:vitaly@thebsh.namesys.com::dnm+9wsmwsV1DMyB:000000000000000000000000000000000000Hpdt
Date: Wed, 06 Jul 2005 16:57:20 -0400
Message-ID: <87ekabejpr.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Wed, 06 Jul 2005 16:57:38 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 14:33:18 -0600, Jonathan Briggs <jbriggs@esoft.com> said:

> On Wed, 2005-07-06 at 15:51 -0400, Hubert Chan wrote:
>> On Wed, 06 Jul 2005 12:52:23 -0600, Jonathan Briggs
>> <jbriggs@esoft.com> said:
> [snip]
>>> It still has the performance and locking problem of having to
>>> update every child file when moving a directory tree to a new
>>> parent.  On the other hand, maybe the benefit is worth the cost.

>> Every node should store the inode number(s) for its parent(s).  Not
>> the path name.  So you don't need to do any updates, since when you
>> move a tree, inode numbers don't change.

> You do need the updates if you change what inode is the parent.

> /a/b/c, /a/b/d, /a/b/e, /b
> mv /a/b /b
> Now you have to change the stored grand-parent inodes for /a/b/c,
> /a/b/d and /a/b/e so that they reference /b/b instead of /a/b.

Don't store (great)*grand-parent pointers; only parent pointers.  c
points to b, b points to a, a points to root.  c doesn't need to know
about /a or root directly.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

