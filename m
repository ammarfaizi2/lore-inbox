Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbQKCPx4>; Fri, 3 Nov 2000 10:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130721AbQKCPxh>; Fri, 3 Nov 2000 10:53:37 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:10758 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130570AbQKCPxU>; Fri, 3 Nov 2000 10:53:20 -0500
Date: Fri, 3 Nov 2000 10:53:19 -0500
From: Crutcher Dunnavant <crutcher@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SysRQ Registration Patch v: 0.10
Message-ID: <20001103105319.A21856@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Red Hat, Inc.
X-Department: OS Development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone interested in advanced debuging features:

I've reved the SysRQ Registration Patch, available at:
http://bama.ua.edu/~dunna001/sysrq-register/

The latest is 0.10, and applies to 2.2.18-pre9, 2.4.0-test10-pre6,
and 2.4.0-test10-pre7. I got tired of reving the patch accross
6 versions, so I am going to do all future revs against the latest 2.2
and 2.4.

I've changed some symbol names to be shorter/saner, cleaned up some formating,
and made some trivial efficieny tweaks that the compiler *should* do on its own,
anyway, but what the hell.

I also played with the example modules a bit, and fixed an SMP problem one of them had.

I really think that this would make a good addition to the kernel, and it touches a
relatively small amount of code. Please examine this, and tell me what you think.

-- 
"I may be a monkey,     Crutcher Dunnavant 
 but I'm a monkey       <crutcher@redhat.com>
 with ambition!"        Red Hat OS Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
