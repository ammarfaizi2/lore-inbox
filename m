Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUH2Ucl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUH2Ucl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUH2Ucl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:32:41 -0400
Received: from box.punkt.pl ([217.8.180.66]:55563 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S268301AbUH2Uck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:32:40 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.8.1
Date: Sun, 29 Aug 2004 22:32:13 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200408292232.14446.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- bugfix release, a couple of minor changes here and there


Nothing special, really. One bigger change - on archs that have >1 possible 
page sizes (PAGE_SIZE definition in asm/page.h) we're now using a call to 
libc's getpagesize(), so don't count on it being static on archs like ia64.

Enjoy.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
