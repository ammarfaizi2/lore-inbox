Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUDIDmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 23:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUDIDmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 23:42:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:44695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262915AbUDIDmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 23:42:22 -0400
Date: Thu, 8 Apr 2004 20:42:47 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: zwane@linuxpower.ca
Subject: [PATCH] make floppy.c readable
Message-Id: <20040408204247.5f960859.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


run scripts/Lindent on drivers/block/floppy.c, but keep some
nicely-formatted structs (tables) and labels as they were.

Same code generated before and after, except for some __LINE__
numbers which changed as expected.

Applies to 2.6.5-mm2.


diffstat:=
 drivers/block/floppy.c | 1712 ++++++++++++++++++++++++-------------------------
 1 files changed, 857 insertions(+), 855 deletions(-)


Patch is approx. 115 KB, so it is available here:
http://developer.osdl.org/rddunlap/patches/floppy_format_265.patch

instead of in this email.

Email containing the patch & sent directly to you is available
upon request.

--
~Randy
