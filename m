Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135264AbRADUuB>; Thu, 4 Jan 2001 15:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135292AbRADUtv>; Thu, 4 Jan 2001 15:49:51 -0500
Received: from dip-32-7.hh1.access.pop.de ([212.79.32.7]:2944 "EHLO
	gerlin1.hsp-law.de") by vger.kernel.org with ESMTP
	id <S135264AbRADUto>; Thu, 4 Jan 2001 15:49:44 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Wedgwood <cw@f00f.org>, "Marco d'Itri" <md@Linux.IT>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.10.10012252135390.7059-100000@penguin.transmeta.com>
From: Ralf Gerbig <gerbig@ibm.net>
Date: 04 Jan 2001 21:44:10 +0100
In-Reply-To: <Pine.LNX.4.10.10012252135390.7059-100000@penguin.transmeta.com>
Message-ID: <m0lmsrdp45.fsf-gerbig@ibm.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.2 (Notus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

[...]

> Almost nothing does that. innd is (sadly) the only regular thing that uses
> this, which is why it's always innd that breaks, even if everything else
> works.

> And even innd is often compiled to use "write()" instead of shared
> mappings (it's a config option), so not even all innd's will break.

just in case nobody else tried, I suffered from the INN problem and it
works for me now with -prerelease, K6 384MB mostly idle exept a small
incoming uucp feed.

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
