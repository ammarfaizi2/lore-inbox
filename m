Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTEKM56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTEKM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:57:57 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:29424 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261350AbTEKM5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:57:30 -0400
Date: Sun, 11 May 2003 15:05:50 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: linux-2.4.21-rc2: unresolved symbols in atyfb
Message-Id: <20030511150550.6e8a1576.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.21-rc2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Under powerpc I've got unresolved symbols in atyfb.o:

depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc2/kernel/drivers/video/aty/atyfb.o
depmod:         display_info
depmod:         mac_var_to_vmode
depmod:         console_fb_info
depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc2/kernel/drivers/video/aty128fb.o
depmod:         display_info
depmod:         mac_vmode_to_var
depmod:         get_backlight_enable
depmod:         mac_var_to_vmode
depmod:         mac_find_mode
depmod:         console_fb_info

atyfb is been compiled as module.

My config on request. I don't wanna spam the list.

*Kristian

-- 

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 ::                            _\_V
  :.........................:
