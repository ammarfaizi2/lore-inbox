Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbRBAOxz>; Thu, 1 Feb 2001 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRBAOxp>; Thu, 1 Feb 2001 09:53:45 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:46610 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S130449AbRBAOxg>; Thu, 1 Feb 2001 09:53:36 -0500
Date: Thu, 1 Feb 2001 09:53:35 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Cc: isp-dns@isp-dns.com
Subject: rlim_t and DNS?
In-Reply-To: <3A7130EE.E314F4A5@megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10102010939230.18810-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to compile bind 9.1.0 here.
Kernel is 2.2.18, gcc 2.7.2.1.
It failed trying to find the type for rlim_t.
The C file says BSD/OS is the only OS they found not to have rlim_t.
Am I missing something?
Where can i find this in linux? I looked in all the include
files, including resource.h
For now i jsut typedefed it as a long.

Also, it's looking for a setting for SYS_capset to pass to syscall()
and can't that either. Again, I looked in the include files without
success.

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
