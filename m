Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbULLKxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbULLKxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 05:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbULLKxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 05:53:40 -0500
Received: from s1.conecto.pl ([193.29.205.125]:14556 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S261767AbULLKxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 05:53:38 -0500
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: linux-kernel@vger.kernel.org
Subject: STIr4200 warnings
Date: Sun, 12 Dec 2004 11:53:33 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412121153.33981@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've started playing with my SigmaTel STIr4200 IrDA bridge and my logs are 
full of warnings (like the one below) just after I run irattach irda0 -s. 
Kernel version is 2.6.10-rc3.

printk: 13 messages suppressed.
usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb() 
instead.
Badness in usb_unlink_urb at drivers/usb/core/urb.c:457

Call Trace:<ffffffff802dbab6>{usb_unlink_urb+86} 
<ffffffff8028994a>{receive_stop+26}
       <ffffffff80289ab0>{stir_transmit_thread+336} 
<ffffffff80146370>{autoremove_wake_function+0}
       <ffffffff80146370>{autoremove_wake_function+0} 
<ffffffff8010edef>{child_rip+8}
       <ffffffff80289960>{stir_transmit_thread+0} 
<ffffffff8010ede7>{child_rip+0}

-- 
mg
