Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269983AbUICXqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269983AbUICXqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269763AbUICXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:46:43 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:58756 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269986AbUICXqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:46:10 -0400
Message-ID: <4139022F.3090507@slaphack.com>
Date: Fri, 03 Sep 2004 18:45:51 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: Spam <spam@tnonline.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902161130.GA24932@mail.shareable.org> <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org> <1835526621.20040903014915@tnonline.net> <1094165736.6170.19.camel@localhost.localdomain> <32810200.20040903020308@tnonline.net> <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org> <142794710.20040903023906@tnonline.net> <Pine.LNX.4.61.0409031730000.23011@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409031730000.23011@fogarty.jakma.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Jakma wrote:
| On Fri, 3 Sep 2004, Spam wrote:
|
|>  Indeed. I hope I didn't say otherwise :).
|
|
| Sure.
|
|>  Just that I think it  will
|>  be very difficult to have this transparency in all apps. Just
|>  thinking of "nano file.jpg/description.txt" or "ls
|>  file.tar/untar/*.doc". Sure in some environments like Gnome it could
|>  work, but it still doesn't for the rest of the flora of Linux
|>  programs.
|
|
| "will it be transparent for all apps?", whether that's worth doing
| depends on the technical implications. Thankfully we have Al and Linus
| to make the judgement call on that ;)

So far, the technical implications are mainly "does it create a serious
issue in the distant future" or "does some exotic new feature that
doesn't exist yet cause problems" and not "it's currently broken".

Right now, I can edit a file's permissions, transparently, from any app,
and I haven't noticed any stability issues at all.

| Personally, I think that if GNOME can provide transparency for GNOME
| users, I think that's probably enough - unless there are literally no
| issues in adding some kind of VFS support.

Only it can't.  Especially if it's a typical GNOME user, who gets used
to having their files encrypted in foo.tar.pgp, say.  Works in abiword,
works in gedit, breaks in OpenOffice.  Not good.

| The nano / ls /tar user is likely a very different user to the GNOME
| user. That user is also likely to appreciate the problems with backups
| and such more.

I'm a vim/ls/tar user.  And I believe the problems with backups to be
very minor.  There are other issues that I don't understand as
thoroughly, so I'll leave them to Al and Linus.

| Anyway, userspace transparency is sufficient for most classes of users.
| Only reason to provide some kernel support is if it makes sense ("but
| not all apps can use GNOME transparency" not being one of those reasons).

Can you justify why "not all apps can use GNOME transparency" is not a
valid reason?  Would you still think so if GNOME transparency was the
only way to read isofs?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTkCL3gHNmZLgCUhAQJVSxAAiFd+e/Q0VjAvPaQL1IDwA56SP7LF2M1v
jnk5wehjvicPEfSn2HpWik7Pr55K2/7dUn6mEJO4N43x/zmfyiA2wXLibfWJtD3X
VgtFMgbOeKu+WobfdnvlBPAKYoZ+MYsC2jyDYwOHguJbR9epmFtHv0mMhmD60s+B
3JDLaYXwPjmjs7zezy2B/Xc3mgm060VgDZRVOnrYZLzHAi3dLvZLzGjORf5kBZtd
NtsiPUZw3oIqORBHqfWDWUUi4irfzklZkiuYp44RNFZs0z0xvPrUJ1klXiJpbQ9t
HTkz9qRe0sxjRYfLcJzWxfahaNN+2SXyR5FFqkpzfUfyNuoOUMZDtin+ZM83qyVc
J/zRCZvWQOaZUtgas9KCCYnbwgCFLcDEE0xLLDRMGAMKeHOwCImU55ChTC/0HTas
Q7Bd0df456dAv+ktbdMRaznWeNOpW5rJWXtxNeWnncTYKG0ogXct9mD0+BEIssaK
qaEYUousp6ZRvOSlCCNCF5hOvfEuZLuAZe2Q8zKH39B4Hg7BMnmIOw6VPLmlLKds
pGNuIKfKjyzkxcdHwqGp36e27wizyKtCbZ58Zd0x1wnf47gkm8kgkY38tb0ct7Xf
Ch+s3+zLsOtVnnipnlGhIPEtxYv78DiqhGUc+pdZisi5VlfA4PTXZAAjoICeXA/H
EqfVU6yYsu8=
=ggxZ
-----END PGP SIGNATURE-----
