Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278568AbRJSSIu>; Fri, 19 Oct 2001 14:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278570AbRJSSIk>; Fri, 19 Oct 2001 14:08:40 -0400
Received: from lhw-65-33-244-104.pompano.net ([65.33.244.104]:3749 "EHLO
	ja.kerneltrap.com") by vger.kernel.org with ESMTP
	id <S278568AbRJSSIX>; Fri, 19 Oct 2001 14:08:23 -0400
Date: Fri, 19 Oct 2001 14:08:53 -0400
From: Jeremy Andrews <jeremy@kerneltrap.com>
To: linux-kernel@vger.kernel.org
Subject: DoS and Root Compromise Kernel Bug?
Message-Id: <20011019140853.445e5237.jeremy@kerneltrap.com>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  Yesterday Rafal Wojtczuk posted to BugTraq regarding two kernel bugs:
   
http://www.securityfocus.com/cgi-bin/archive.pl?id=1&mid=221337&start=2001-10-15&end=2001-10-21

  I'm curious to understand more about these bugs.  I.E., are they real?  And,
are they fixed in 2.4.12 as claimed?  How about in the -ac series?

  The first kernel bug is regarding symbolic links. Rafal says it is partially
fixed in 2.4.10, and completely fixed in 2.4.12. This bug allows for a local
user to carry out a Denial of Service attack.

  The second bug allows for a root compromise via ptrace. The requirements are
that /usr/bin/newgrp be suid root (as in my RedHat 7.0 server), and that newgrp
not prompt for a password when run without arguments (again, as is the case with
my RedHat 7.0 server). Rafal says the attack only appears to work on Linux.

Thanks,
 -Jeremy
--
 Jeremy Andrews    <mailto:jeremy@kerneltrap.com>
 PGP Key ID: 8F8B617A  http://www.kerneltrap.com/
