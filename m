Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJUMfo>; Sun, 21 Oct 2001 08:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276050AbRJUMfe>; Sun, 21 Oct 2001 08:35:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15119 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276032AbRJUMfU>; Sun, 21 Oct 2001 08:35:20 -0400
Subject: Re: DoS and Root Compromise Kernel Bug?
To: jeremy@kerneltrap.com (Jeremy Andrews)
Date: Sun, 21 Oct 2001 13:42:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011019140853.445e5237.jeremy@kerneltrap.com> from "Jeremy Andrews" at Oct 19, 2001 02:08:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vHvf-0006D4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Yesterday Rafal Wojtczuk posted to BugTraq regarding two kernel bugs:
>    
> http://www.securityfocus.com/cgi-bin/archive.pl?id=1&mid=221337&start=2001-10-15&end=2001-10-21
> 
>   I'm curious to understand more about these bugs.  I.E., are they real?  And,
> are they fixed in 2.4.12 as claimed?  How about in the -ac series?

2.4.12 / 2.4.12-ac have both fixed.
2.2.20 is still pending but will fix it

>   The second bug allows for a root compromise via ptrace. The requirements are
> that /usr/bin/newgrp be suid root (as in my RedHat 7.0 server), and that newgrp
> not prompt for a password when run without arguments (again, as is the case with
> my RedHat 7.0 server). Rafal says the attack only appears to work on Linux.

So far yes. The FreeBSD folks and others were also made privy to the problem
well before he published it to bugtraq and seem to be completely in the
clear.

Alan
