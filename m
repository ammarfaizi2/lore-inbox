Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310187AbSB1W6J>; Thu, 28 Feb 2002 17:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310192AbSB1W4M>; Thu, 28 Feb 2002 17:56:12 -0500
Received: from smtp.comcast.net ([24.153.64.2]:47144 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S293758AbSB1WvD>;
	Thu, 28 Feb 2002 17:51:03 -0500
X-URL: genehack.org
Date: Thu, 28 Feb 2002 17:51:00 -0500
From: jacobs@genehack.org (John S. J. Anderson)
Subject: Procfs-related core dump deadlock
To: linux-kernel@vger.kernel.org
Message-id: <877koxxlt7.fsf@mendel.genehack.org>
Organization: genehackCorps
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
X-Attribution: john
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings --

We've been experiencing some strange situations on our production
machines, which look identical to the problems described in
<http://lists.insecure.org/linux-kernel/2001/Dec/1539.html>.

A follow-up to that message
(<http://lists.insecure.org/linux-kernel/2001/Dec/1604.html>) mentions
that the problem is likely to be due to a deadlock associated with the
coredump process.

The first message has some quoted text claiming that the problem went
away in 2.4.10, but the poster is seeing it in 2.4.14, and we're still
seeing it in 2.4.17-aa.

Does anybody have any idea of where to start looking, or what could
have changed in the 2.4.10 -> 2.4.14 time frame that would have
re-introduced this behavior?

We're currently kludging around the problem with 'ulimit -c 0' in
relevant environments, but it would be nice to have a real fix.

john.
-- 
The only skills I have the patience to learn are those that have no real
application in life.  -- Calvin
