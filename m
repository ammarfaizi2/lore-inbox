Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbVFYAgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVFYAgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 20:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVFYAgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 20:36:42 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8152 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263156AbVFYAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 20:35:23 -0400
Message-ID: <42BCA6C4.9060800@namesys.com>
Date: Fri, 24 Jun 2005 17:35:16 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain> <42BC5D2E.1070307@namesys.com> <20050624230644.GA20185@thunk.org>
In-Reply-To: <20050624230644.GA20185@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fsck is better in V4 than it is in V3. Users should move from V3 to V4,
as V3 is obsolete. I agree on that Ted.

I also agree that Ted did a great job with fsck.ext*.

V3 was where we learned. There are performance problems in V3 that I
could only fix by writing V4. The balancing code for V3 was extremely
difficult to modify because it understood all the internals of the item
structures, and that is why we based V4 on plugins. V3 had a time where
it was really useful, and the time when it was the only metadata
journaling filesystem for Linux was its high point (thanks Chris), but
its usefulness is leaving us very soon now with V4. In 12 months, after
V4 has been pounded on by a few million users, few will want to make new
installs onto V3 instead of V4.

It would be nice if we could concentrate on speeding that transition
instead of flaming each other.

I would like to thank the ext* team, especially Ted, for a great
filesystem that I used for many years while developing V3, that was
crucial to the early success of Linux, and that is still useful to a
great many.

Hans
