Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSLWCDE>; Sun, 22 Dec 2002 21:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSLWCCE>; Sun, 22 Dec 2002 21:02:04 -0500
Received: from dp.samba.org ([66.70.73.150]:165 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265683AbSLWCCA>;
	Sun, 22 Dec 2002 21:02:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: dougg@torque.net
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
Subject: Re: [PATCH] scsi_debug version 1.67 for lk 2.5.52 
In-reply-to: Your message of "Sat, 21 Dec 2002 10:17:58 +1100."
             <3E03A526.1040405@torque.net> 
Date: Mon, 23 Dec 2002 12:08:05 +1100
Message-Id: <20021223021009.D4B212C0EC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E03A526.1040405@torque.net> you write:
> This patch uses the module_param() facility introduced in
> lk 2.5.52 (see linux/moduleparam.h) to simplify boot time
> and module load time parameters for the scsi_debug driver.

This is great.  The question remains of what to do with
MODULE_PARM_DESC(), currently an empty macro.

Reverting them to be stored in ".modinfo" section as was done
previously is trivial, but as they are now also boot parameters, which
points to a DocBook-style solution.

The same arguments apply to MODULE_AUTHOR, and MODULE_DESCRIPTION.

Preferences anyone?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
