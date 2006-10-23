Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWJWCaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWJWCaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 22:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWJWCaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 22:30:04 -0400
Received: from webserve.ca ([69.90.47.180]:28124 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S1751188AbWJWCaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 22:30:03 -0400
Message-ID: <453C2903.1060906@wintersgift.com>
Date: Sun, 22 Oct 2006 19:29:23 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-git7 shutdown problem
References: <20061022145210.n736g78k42e8ggkg@69.222.0.225> <Pine.LNX.4.64.0610221356440.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610221356440.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Sun, 22 Oct 2006, art@usfltd.com wrote:
>> 2.6.19-rc2-git7 shutdown problem
>>
>> below are last shutdown messages - system is hunging forever !
>> hda was mounted, hdb not
>> any clue ?
> 
> Noting springs to mind immediately.
> 
> Can you narrow this down more specifically? Did you test 2.6.19-rc2-git6, 
> and that was fine? Or did you just happen to test -git7, and the previous 
> kernel you did this on was some much older one?

I'm seeing the same thing here between rc2-git6 and rc2-mm2 on intel
945-based hardware and similar.   (rc2-git6 WORKS, rc2-mm2 FAILS)
rc2-git6: for the most part works fine.
rc2-mm2: Restart works - shutdown freezes.

these units otherwise work almost completely: C3 mode doesn't work but
C4 DOES (ACPI sleep if I remember names correctly).

I did not test -git7 (or later).   I could if that would help.
- - Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPCjybFT/SAfwLKMRAo+tAJ0XE0/zXvsDQnnGikbcF6pvmlh+xACffOBh
dUumPzGFGLxGb76mtvNtcQ4=
=dvWQ
-----END PGP SIGNATURE-----
