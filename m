Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTADTzm>; Sat, 4 Jan 2003 14:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTADTzm>; Sat, 4 Jan 2003 14:55:42 -0500
Received: from web13708.mail.yahoo.com ([216.136.175.141]:21397 "HELO
	web13708.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261346AbTADTzm>; Sat, 4 Jan 2003 14:55:42 -0500
Message-ID: <20030104200415.7387.qmail@web13708.mail.yahoo.com>
Date: Sat, 4 Jan 2003 12:04:15 -0800 (PST)
From: Mad Hatter <slokus@yahoo.com>
Subject: 2.5.54 Makefile question: set -e
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The toplevel Makefile in 2.5.54 has near line 313:

----------------------------
#	set -e makes the rule exit immediately on error
#...
attribute if uninitialized.

define rule_vmlinux__
	set -e
...
endef
-------------------------

However, the "set -e" does nothing since each line is
processed by a different shell according to the make
manual.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
