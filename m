Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129392AbQKVVaM>; Wed, 22 Nov 2000 16:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130671AbQKVVaC>; Wed, 22 Nov 2000 16:30:02 -0500
Received: from d14144.dtk.chello.nl ([213.46.14.144]:8328 "EHLO
        amadeus.home.nl") by vger.kernel.org with ESMTP id <S129392AbQKVV34>;
        Wed, 22 Nov 2000 16:29:56 -0500
Message-Id: <m13ygzS-000OZ3C@amadeus.home.nl>
Date: Wed, 22 Nov 2000 21:59:38 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: law@sgi.com (LA Walsh)
Subject: Re: include conventions /usr/include/linux/sys ?
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com> you wrote:
> Linus has mentioned a desire to move kernel internal interfaces into
> a separate kernel include directory.  In creating some code, I'm wondering
> what the name of this should/will be.  Does it follow that convention
> would point toward a linux/sys directory?

I would vote for

include/linux		-	 exported interfaces
include/kernel		-	 kernel internal interfaces
include/asm		- 	 kernel internal/archspecific interfaces

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
