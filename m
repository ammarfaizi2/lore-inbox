Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268718AbUIGWQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268718AbUIGWQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUIGWOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:14:49 -0400
Received: from mx02.qsc.de ([213.148.130.14]:55712 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268703AbUIGWO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:14:28 -0400
Date: Wed, 08 Sep 2004 00:13:20 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Christer Weinigel <christer@weinigel.se>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       Spam <spam@tnonline.net>, ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>, Christer Weinigel <christer@weinigel.se>
Subject: Re: silent semantic changes with reiser4
Message-ID: <413E3280.nailEK92X8CU7@pluto.uni-freiburg.de>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <1183150024.20040907143346@tnonline.net>
 <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
 <m34qm9kbcl.fsf@zoo.weinigel.se>
In-Reply-To: <m34qm9kbcl.fsf@zoo.weinigel.se>
User-Agent: nail 11.7pre 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel <christer@weinigel.se> wrote:

> Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de> writes:
> > No, it would not. If you read the POSIX.1 specification for cp
> > carefully <http://www.unix.org/version3/online.html>, you will
> > notice that the process for copying a regular file is carefully
> > standardized. A POSIX.1-conforming cp implementation would not
> > be allowed to copy additional streams, unless either additional
> > options are given or the type of the file being copied is other
> > than S_IFREG. And cp is just one example of a standardized file
> > handling program.
> We can safely ignore POSIX when it is too broken.

Excuse me, but there's really nothing broken here with POSIX and cp.
You're just making an insulting talk about a part of the specification
which currently serves GNU/Linux and other Unix-like environments very
well, and has done so for about twelve years now.

> cp could very well be modified to copy named streams except when
> the option --posix is specified

Hey, you didn't ever even have a look at POSIX Shell & Utilities, did
you? Then why are you making derogatory statements about it?

> or the environment variale POSIXLY_CORRECT is set.

Cool, data loss depending upon an environment variable which is even
currently used by many programs unaware of such results. This really
sounds like good engineering to me.

	Gunnar
