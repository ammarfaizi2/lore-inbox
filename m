Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTJHCs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 22:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTJHCs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 22:48:28 -0400
Received: from mail.inter-page.com ([12.5.23.93]:57609 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261434AbTJHCs1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 22:48:27 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Robert White'" <rwhite@casabyte.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9? (SIGPIPE?)
Date: Tue, 7 Oct 2003 19:47:09 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAp904CFg3kEGlG8vIGe/66QEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAeFyz/E9s7UuIuyU9yNzATQEAAAAA@casabyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



PS this may be dumb but...

If all the CLONE_THREAD members of a process (automatically) have the same
signal handling code/context but not the same list of file descriptors, what
happens when a file descriptor posts SIGPIPE or SIGIO (etc.) to a process?

Rob.


