Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTGFRRL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTGFRRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:17:11 -0400
Received: from smtp03.web.de ([217.72.192.158]:17699 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262714AbTGFRRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:17:09 -0400
Subject: [OOPS] Linux 2.5.74-bk4 & XFS == oops
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1057512700.827.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 
Date: Sun, 06 Jul 2003 19:31:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This problem is following me since I first played with 2.5 (around
2.5.52). Every now and then the XFS driver causes a Kernel oops. First I
thought this may be a normal issue because it's a development Kernel and
I ignored it because I hoped that this was a known issue and tracked
down one day. But yesterday I had 3-4 of these oops'es in a row and now
I gonna report this in hope to see it fixed really soon.

I compiled kmsgdump-2565.diff into the Kernel (with some minor tweaks)
and tried to force this issue for half a day and guess, as soon as it
comes to demonstration it doesn't happen but I bet my pants that this
problem will show up pretty soon anyways.

Ok I can't show you a full output but I wrote the last one down on
paper.

;-------------------------------
fs/xfs/pagebuf/page_buf.c:1288
Unknown command: 00000000
;-------------------------------

I am not sure for the second line if it should say 'unknown command' but
something like this. Sorry, I can't offer you more right now but better
this than nothing.

