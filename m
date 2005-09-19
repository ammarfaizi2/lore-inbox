Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVISGxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVISGxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVISGxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:53:34 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:36480 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750730AbVISGxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:53:33 -0400
Message-ID: <432E606D.9020009@namesys.com>
Date: Sun, 18 Sep 2005 23:53:33 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Christoph Hellwig <hch@infradead.org>,
       Christian Iversen <chrivers@iversen-net.dk>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <200509181321.23211.vda@ilport.com.ua> <20050918102658.GB22210@infradead.org> <200509181406.25922.chrivers@iversen-net.dk>            <432E499B.7000003@namesys.com> <200509190556.j8J5utH0024042@turing-police.cc.vt.edu>
In-Reply-To: <200509190556.j8J5utH0024042@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>
>
> Hans, unfortunately the most obvious reading of the above is
> "Reiser4 is so damned fast because it doesn't bother doing
> sanity-checking".

Hmm, you seem to have forgotten the Hellwig complaints about too many
assertions..... ;-)

Algorithms make a difference Valdis, they make a big difference.
> If there's still more "fixmes" to be inserted that *you* know of,
> and there are so many that there's no time to fix them, why is this
> being submitted for inclusion?

The fixmes are not bugs, those got fixed, they are "this code would be
cleaner if written another way", or, most commonly, "where is the
comment that ought to be here?"

> On Sun, 18 Sep 2005 22:09:08 PDT, Hans Reiser said:
>
>> Of course, the reiser4 code is not as stable as it was before the
>> changes Christoph asked for.
>
>
> This sort of claim requires proof - can you point at *specific*
> things that were less stable after you fixed the code, including
> explaining why they're less stable?

The 4k stacks got a bug report or two.   Generally speaking, I don't
trust any large number of lines of code of changes to be bug free, and
the VFS stuff was a large number of lines.

