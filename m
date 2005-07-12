Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVGLXSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVGLXSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGLXSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:18:08 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:4679 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262444AbVGLXQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:16:21 -0400
Message-ID: <42D44F3C.6080707@suse.com>
Date: Tue, 12 Jul 2005 19:16:12 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH/URL] reiserfs: reformat code with Lindent
References: <20050712194220.GA28973@locomotive.unixthugs.org> <Pine.LNX.4.58.0507121546160.17536@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507121546160.17536@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Tue, 12 Jul 2005, Jeff Mahoney wrote:
>> This patch contains the result of running scripts/Lindent against
>> fs/reiserfs/*.c and include/linux/reiserfs_*.h.
> 
> That can't be true. It isn't actually following the Lindent rules. It has 
> that braindamaged "put the type on a separate line" thing for function 
> declarations, making a "grep" not show the type. That's very much against 
> the Linux coding style.
> 
> So either your "indent" is broken, or you've used something else than 
> Lindent.
> 
> Also, if it's a pure indentation change with no other changes, I'd almost 
> prefer it as a script, not a patch.  That way it's obvious to everybody 
> that it's just doing indentation.

Sigh. I guess some options in my .indent.pro overrode those in
scripts/Lindent. I just assumed it would do its job.

At any rate, the goal really is only to change the indentation to the
Linux standard, so I'll post a pre-patch to fix up a case where indent
misreads the code and indents a tab stop, as well as the one liner to
reformat.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFC1E88LPWxlyuTD7IRAt6iAJ4lLRdo8Pm9FLMRSKR2EnNX9JO6ogCgiTFG
kCkCafDtbstfWigkN8m/9U8=
=p+20
-----END PGP SIGNATURE-----
