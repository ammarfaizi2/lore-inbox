Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbULZNms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbULZNms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbULZNms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:42:48 -0500
Received: from siaag2af.compuserve.com ([149.174.40.136]:3512 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261651AbULZNml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:42:41 -0500
Date: Sun, 26 Dec 2004 08:38:25 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: lease.openlogging.org is unreachable
To: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200412260839_MC3-1-91CA-FAF5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> The interesting thing is that the code already has a backup in it and I just
> checked that code path and it works.

 Huh.  The first time the lease renewal hung up and I hit ctrl-C when it
didn't seem to be working (tcpdump showed a series of unanswered SYNs.)
Later I let it run to completion and it must have worked, but since there
was no output from the program I assumed it had just failed silently like
some other bitkeeper commands will do. Then the Christmas morning mayhem
hit and I didn't have any more time to play with it.

 You should output a confirmation message when 'bk lease renew' succeeds.

--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
