Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUIGVmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUIGVmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268689AbUIGVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:41:40 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:31195 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268634AbUIGVjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:39:24 -0400
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Cc: Spam <spam@tnonline.net>, Christer Weinigel <christer@weinigel.se>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain>
	<413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
	<1183150024.20040907143346@tnonline.net>
	<413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 07 Sep 2004 23:39:22 +0200
In-Reply-To: <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
Message-ID: <m34qm9kbcl.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de> writes:

> No, it would not. If you read the POSIX.1 specification for cp
> carefully <http://www.unix.org/version3/online.html>, you will
> notice that the process for copying a regular file is carefully
> standardized. A POSIX.1-conforming cp implementation would not
> be allowed to copy additional streams, unless either additional
> options are given or the type of the file being copied is other
> than S_IFREG. And cp is just one example of a standardized file
> handling program.

We can safely ignore POSIX when it is too broken.  cp could very well
be modified to copy named streams except when the option --posix is
specified or the environment variale POSIXLY_CORRECT is set.

  /Christer


-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
