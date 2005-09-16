Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbVIPRFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbVIPRFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbVIPRFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:05:10 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:57329 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161191AbVIPRFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:05:09 -0400
Message-ID: <432AFB44.9060707@namesys.com>
Date: Fri, 16 Sep 2005 10:05:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: I request inclusion of reiser4 in the mainline kernel
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All objections have now been addressed so far as I can discern.

    The VFS layering issue was addressed after 2 months of recoding.

    The undesired type safe lists were removed after ~ a man week of coding.

    Cosmetic issues regarding line length, etc., were addressed.

    Numerous ~ one line changes were made that I will not address here.

    The assertions were left in, with akpm's ok.

    Pseudo files were removed.

    dependency on !4k stacks was removed and stack usage was fixed.

    reiser4_drop_inode was removed.

    our div64_32 was replaced with the linux one

I request that reiser4 be included.  Technically, we submitted 9 months
before the deadline for 2.6.14, though I am sure the point will be
argued.  We would have submitted our feedback fixes on monday but we
lost the type safe lists argument over the weekend before monday, so it
delayed us.

There have been no bug reports concerning the new code. 

If we get lucky, we might also have a compression plugin working by the
time 2.6.14 ships, it just needs some mmap fixes to work.  Then the
benchmarks will be truly excessive.....  even after we rewrite them
because they currently generate files that compress too well to be
realistic.....

:)

Thanks to all for your kind suggestions of improvements to our work, and
the time you invested in providing us with feedback.  It will be easier
to use meta-. to browse our code now that the type safe lists are gone,
etc., etc.

Hans
