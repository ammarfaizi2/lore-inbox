Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVF2RA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVF2RA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVF2RA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:00:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:37040 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262618AbVF2Q6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:58:39 -0400
X-Authenticated: #25753041
From: Genadz Batsyan <gbatyan@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Newbie: added function not visible
Date: Wed, 29 Jun 2005 18:59:04 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291859.04965.gbatyan@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm desperate, please help, if I'm missing something obvious.

I am trying to add a function to the file drivers/char/keyboard.c
and then be able to call this function from my kernel module

adding the function to keyboard.c, recompiling and booting with kernel
results  /proc/kallsyms telling me that my function exists with the tag 'T',
which I think is ok

In my module I simply declare the function's prototype and use it.

When trying to compile the module, modpost tells that the function's symbol
is not found. (insmodding results in error too)

I don't get it, WHY tha heck can it find all the other stuff and 
what makes this new function different? I have read that 2.6 kernel exports
any non-static symbols.

Regards!
