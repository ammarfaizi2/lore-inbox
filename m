Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbTGHTHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267547AbTGHTHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:07:34 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:40127 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S267545AbTGHTH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:07:27 -0400
Date: Wed, 09 Jul 2003 07:22:08 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Tainted: S
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1057692128.14471.10.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

With the latest prepatch for the 2.4 version of swsusp, I've made swsusp
taint the kernel upon resume from a suspend-to-disk. Any oopses that
occur afterwards will contain S as a third character (eg PFS). This so
that maintainers can be aware that software suspend might play a role in
any oopses they get.

Note that this doesn't apply to the version of software suspend in the
2.5 tree at the moment. I intend to port the 2.4 patch to 2.5/6, but if
I succeed in getting it merged, it will take a while (2.7 I guess), so
software suspend may play a role in cases where you don't get an 'S'.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

