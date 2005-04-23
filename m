Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVDWVro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVDWVro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVDWVro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:47:44 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:39071 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262000AbVDWVrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:47:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] swsusp: misc cleanups [0/4]
Date: Sat, 23 Apr 2005 23:20:54 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504232320.54477.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You said you wanted something to  to try git on, so here you go. ;-)

The following series of patches contains some cleanups for swsusp.c.  IMO,
they are not very important, but at least the first two of them need to go
at some time.

In the order of decreasing importance:
1/4 - move the recalculation of nr_copy_pages so that the right number is used
	in enough_free_mem() and enough_swap()
2/4 - drop the unnecessary function does_collide_order()
3/4 - clean up whitespace
4/4 - make some comments and printk()s up to date

The first three patches are against 2.6.12-rc3 and they are mutually independent.
The last one is on top of the first three.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

