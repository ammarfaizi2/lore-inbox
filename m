Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTLUDag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 22:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTLUDag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 22:30:36 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48320 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262153AbTLUDae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 22:30:34 -0500
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1071969177.1742.112.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Dec 2003 20:12:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
> On Thu, 18 Dec 2003, Lennert Buytenhek wrote:

>> What am I to do?  Ignore the patent?  Or should
>> I refrain from submitting the patch I wrote,
>> and look for an unencumbered algorithm instead?
>
> Don't submit, and find an unencumbered algorithm.
> Unless you can get the patent holder to grant a
> license (it does happen).

What about the obvious Kconfig option?

config PATENT_1234567890
        bool "Patent 1234567890"
        default n
        help
          Say Y here if you have the right to use
          patent 1234567890 (the foo patent). Some
          countries do not recognise this patent, an
          educational or research exemption may apply,
          you may be the patent holder, the patent
          may have expired, or you may have aquired
          rights via licensing. Seek legal help if you
          need advice concerning your rights. If unsure,
          say N.

This assumes that the patented algorithm is
important enough to bother with, and we'd all
hope a non-patented alternative is available
for those of us without rights to the patent.


