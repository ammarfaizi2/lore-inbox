Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271341AbTGQCzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271342AbTGQCzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:55:07 -0400
Received: from mailg.telia.com ([194.22.194.26]:49905 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S271341AbTGQCzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:55:03 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test1-mm1] Rivafb does compile
From: Christian Axelsson <smiler@lanil.mine.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058411386.26910.3.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 05:09:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get these when trying to compile rivafb:

  CC      drivers/video/riva/fbdev.o
drivers/video/riva/fbdev.c: In function `rivafb_cursor':
drivers/video/riva/fbdev.c:1525: warning: passing arg 2 of
`move_buf_aligned' from incompatible pointer type
drivers/video/riva/fbdev.c:1525: warning: passing arg 4 of
`move_buf_aligned' makes pointer from integer without a cast
drivers/video/riva/fbdev.c:1525: too few arguments to function
`move_buf_aligned'
drivers/video/riva/fbdev.c:1527: warning: passing arg 2 of
`move_buf_aligned' from incompatible pointer type
drivers/video/riva/fbdev.c:1527: warning: passing arg 4 of
`move_buf_aligned' makes pointer from integer without a cast
drivers/video/riva/fbdev.c:1527: too few arguments to function
`move_buf_aligned'

I have seen various posts on this driver (with slightly different
errors) but no followups.

-- 
Christian Axelsson
smiler@lanil.mine.nu

