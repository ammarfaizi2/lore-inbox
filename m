Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRKXWox>; Sat, 24 Nov 2001 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280430AbRKXWon>; Sat, 24 Nov 2001 17:44:43 -0500
Received: from cc125153-a.ensch1.ov.nl.home.com ([213.51.201.158]:52980 "HELO
	luggage.discworld.org") by vger.kernel.org with SMTP
	id <S280426AbRKXWo2>; Sat, 24 Nov 2001 17:44:28 -0500
Message-ID: <3C0027BC.CC76D1D1@tfn.net>
Date: Sun, 25 Nov 2001 00:05:32 +0100
From: Robert Boermans <boermans@tfn.net>
Organization: ICT
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.20 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.0 breakage even with fix?
In-Reply-To: <Pine.GSO.4.21.0111231909421.4000-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> fsck -f
>
> Filesystem _is_ marked clean, so unless you do forced fsck no checks
> are done.
>
> Moreover, attempt to work with corrupted fs can break in very interesting
> ways, so unless you do fsck -f even correct kernel (be it patched 2.4.15
> or something earlier than 2.4.15-pre9) will not help.

If the filesystem is marked clean, does that mean that people with
journalling file systems are fscked? (since there might be no journal entry
of what hasn't finished.)

just guessing, I don't know how these work, but if ext2 gets the 'clean' bit
set, i can imagine the journaling file systems refusing to check anything...

Robert.

