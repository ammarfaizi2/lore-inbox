Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUC1O1e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 09:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUC1O1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 09:27:34 -0500
Received: from box.punkt.pl ([217.8.180.66]:12813 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261824AbUC1O1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 09:27:32 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.4.0
Date: Sun, 28 Mar 2004 16:23:39 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200403281623.39867.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.4
- added documentation (readme, changelog, license, authors)
- linux/hdreg.h - 2.4 stuff
- linux/major.h - 2.4 definitions
- minor changes

README file follows:

The linux-libc-headers (llh) package (available at
http://ep09.pld-linux.org/~mmazur/linux-libc-headers/) contains headers
that export linux abi to userspace. These headers are a heavily modified and
cleaned up version of what comes with original linux tarball. The first three
digits of llh's version tag correspond to the version of linux kernel of which
abi is exported, but keep in mind there are lots of 2.4 kernel compatibilities
included.

Userland usefulness is achieved by removing kernel only parts (which often
generate errors) and using code provided by libc where possible (this allows
to avoid collisions when both linux and libc headers define the same structure
or constant). Unfortunately libc dependency might result in functionality loss
since libcs aren't always in sync with what kernel provides. If such a case
occurs please send a bug report to the maintainer (see AUTHORS file) and, if
possible, a workaround will be added. Do note that since llh is primarily for
2.6 based kernels we assume glibc to be at least version 2.3.3 (as far as I
know this version wasn't released officially but is being used by many current
linux distributions). Glibc is not a requirement though - llh is known to work
with other implementations of standard C library - but obviously is a
priority, so be prepared to send a bugreport if using something else.
In case you're wondering why take such an approach if it's obvious that it
might generate problems. Well, according to my knowledge there is consensus
among kernel hackers as to how userland headers should look like, but
unfortunately proper implementation (and wider adoption) will take time and
something that just plain works (in most cases anyway) is needed now.


Enjoy.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
