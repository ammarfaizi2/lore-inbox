Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVAVVI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVAVVI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAVU7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:59:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:34222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262734AbVAVUoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:44:44 -0500
Date: Sat, 22 Jan 2005 12:44:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Fw: [Bugme-new] [Bug 4081] New: OpenOffice crashes while starting
 due to a threading error
Message-Id: <20050122124413.5649aa93.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is anyone else seeing this?


Begin forwarded message:

Date: Sat, 22 Jan 2005 08:35:26 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4081] New: OpenOffice crashes while starting due to a threading error


http://bugme.osdl.org/show_bug.cgi?id=4081

           Summary: OpenOffice crashes while starting due to a threading
                    error
    Kernel Version: 2.6.11-rc2
            Status: NEW
          Severity: blocking
             Owner: process_other@kernel-bugs.osdl.org
         Submitter: diego@pemas.net


Distribution: Debian
Hardware Environment: Pentum III 733 MHz
Software Environment: Debian Sid
Problem Description:
While starting open Office crashes, it did not happend on 2.6.10, but happend on
2.6.11. rc1 and rc2. The only thing that has changed is the kernel. If i go back
to 2.6.10 OpenOffice starts just fine.

gdb shows that it crashes during this call:
thread_get_info_callback: cannot get thread info: generic error

the logs kern.log and messages don't show anything related to this crash.

Steps to reproduce:

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
