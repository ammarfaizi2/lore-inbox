Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUFQX2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUFQX2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 19:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUFQX2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 19:28:09 -0400
Received: from CPE-65-30-20-102.kc.rr.com ([65.30.20.102]:1414 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S264138AbUFQX2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 19:28:06 -0400
Message-ID: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
Date: Thu, 17 Jun 2004 18:28:04 -0500 (CDT)
Subject: Using kernel headers that are not for the running kernel
From: "Nick Bartos" <spam99@2thebatcave.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a little distro that I am trying to upgrade to 2.6.x.

The problem is that when I use the headers for 2.6.x, glibc 2.2.5 won't
compile.  Eventually I want to upgrade glibc/gcc, but not at the moment. 
If I use the headers from 2.4.26 for the system, but just compile the
2.6.7 kernel, things do compile fine for everything.

This distro is small, and I can rebuild the entire thing in about 90 mins,
so if I change the kernel (or really anything that has other deps), I just
rebuild the entire thing to make sure everything is in sync.

I see that a lot of distros use a separate package for the kernel headers,
which do not necessarily coincide with the running kernel.

I am wondering what (if any) are the side effects of doing this are,
especially when the kernel versions are so different.  I was thinking that
there may be issues with some progs if the prototypes for certain kernel
functions weren't the same.  However people are doing it and it does seem
to work, but I am wondering how it fends for stability.

Comments?
