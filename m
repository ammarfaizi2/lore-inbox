Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUCPRWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbUCPRW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:22:28 -0500
Received: from main.gmane.org ([80.91.224.249]:41182 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264201AbUCPRTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:19:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Dealing with swsusp vs. pmdisk
Date: Mon, 15 Mar 2004 15:17:01 -0800
Message-ID: <m2d67dr98y.fsf@tnuctip.rychter.com>
References: <20040312224645.GA326@elf.ucw.cz> <20040313004756.GB5115@thunk.org>
 <20040313122819.GB3084@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: g3.rychter.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:Ra77AVYyci0P9E8ivuY/gg1fMFs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
[...]
Theodore Ts'o <tytso@mit.edu>:
 >> Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
 >> complaint about it is that since it's maintained outside of the
 >> kernel, it's constantly behind about 0.75 revisions behind the
 >> latest 2.6 release.  The feature set of swsusp2, if they can ever
 >> get it completely bugfree(tm) is certainly impressive.

 Pavel> My biggest problem with swsusp2 is that it is big. Also last
 Pavel> time I looked it had some ugly hooks sprinkled all over the
 Pavel> kernel. Then there are some features I don't like (graphical
 Pavel> screens with progress, escape-to-abort) and
 Pavel> ithasvariableslikethis. OTOH it supports highmem and smp.  

It also has the advantage of working extremely reliably on 2.4 (and a
large part of the code base is shared, so that's a significant data
point). I couldn't get it to crash or do anything bad for months now,
and I'm doing at least several suspend/resumes a day on my laptop.

Also, thanks to the excellent compression feature, suspend/resume times
are very short and in fact competitive with suspend-to-ram schemes.

I think it's better not to mix personal preferences (such as the
escape-to-abort thing) with technical discussions. On a practical level,
swsusp2 is the only implementation which works reliably, does its job
very well, and has a responsive maintainer willing to fix problems as
they arise.

--J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAVjlyLth4/7/QhDoRAgfFAJ9YE2u/0Ajmc6oXx0UvATu/p8hr+QCfesjL
jCFaYCcrSkj2mvz9zrncPXI=
=0pEy
-----END PGP SIGNATURE-----
--=-=-=--

