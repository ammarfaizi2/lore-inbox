Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUBHX3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUBHX3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:29:00 -0500
Received: from bugs.pld-linux.org ([193.219.28.21]:33647 "EHLO
	ep09.pld-linux.org") by vger.kernel.org with ESMTP id S264376AbUBHX27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:28:59 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: linux-libc-headers 2.6.1.3 released
Date: Mon, 9 Feb 2004 00:25:55 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402090025.55087.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
At http://ep09.pld-linux.org/~mmazur/linux-libc-headers/patches/ one can find 
patches for things that don't compile (they remove workarounds for bugs in 
original headers that break compilation when headers aren't broken :). I hope 
to push them to application maintainers.

Changes:
- The name changed. Old name (glibc-kernel-headers) was not adequate. These 
headers can be used with eg. uClibc without any problems.
- define __bswap_constant* if missing in glibc
- HZ definition on i386 is again a constant 
- framebuffer fixes for sparc
- some other fixes



-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
