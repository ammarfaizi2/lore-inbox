Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQU27>; Fri, 17 Nov 2000 15:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQU2s>; Fri, 17 Nov 2000 15:28:48 -0500
Received: from 62-6-231-5.btconnect.com ([62.6.231.5]:57472 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129097AbQKQU2o>;
	Fri, 17 Nov 2000 15:28:44 -0500
Date: Fri, 17 Nov 2000 20:00:49 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: test11-pre6 still very broken
Message-ID: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The mysterious lockups in test11-pre5 continue in test11-pre6. It is very
difficult because the lockups appear to be kdb-specific (and kdb itself
goes mad) but when there is no kdb there is very little useful information
one can extract from a dead system...

I will start removing kernel subsystems, one by one and try to reproduce
it on as plain kernel as possible (i.e. just io, no networking etc.)

So, this not-very-useful report just says -- test11-pre6 is extremely
unstable, a simple "ltrace ls" can cause a lockup. Also, some programs
work when run normally but coredump (or hang) when run via strace, but
only sometimes, not always... (no, I don't have faulty memory, I run
memtest!)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
