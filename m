Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263592AbUEWVJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUEWVJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUEWVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:09:23 -0400
Received: from [82.228.82.76] ([82.228.82.76]:58095 "EHLO
	paperstreet.colino.net") by vger.kernel.org with ESMTP
	id S263592AbUEWVJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:09:22 -0400
Date: Sun, 23 May 2004 23:09:04 +0200
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.6-bk9, quick test
Message-Id: <20040523230904.26e7c77c@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.10claws67.4 (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I gave a shot at linux 2.6.6-bk9 on PPC32 (ibook G4) today, noticed two
problems. First, pbbuttonsd complains about /dev/adb missing and indeed,
it isn't there. Looks like related to Ben's changes to
drivers/macintosh/adb.c, but maybe due to some devfs (I know, outdated
;-)) configuration problem?

Second problem, tried to mount an usb key, and it failed: mount hung.
(ehci driver).

I didn't have time to investigate this stuff, but thought it could help
to mention it ?

Thanks,
-- 
Colin
