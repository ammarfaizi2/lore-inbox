Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbULCR2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbULCR2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbULCR2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:28:05 -0500
Received: from mail.linicks.net ([217.204.244.146]:46085 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262373AbULCRPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:15:17 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: newbie kernel hacking question.
Date: Fri, 3 Dec 2004 17:15:15 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031715.15067.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to learn more in operation of kernel, and decided to attempt some 
small hacks with a meaningful purpose - 'see it in action' type stuff rather 
than just play.

One area to start with I decided is the keyboard warning at boot.  I have 5 
headless/keyboardless boxes and wish the kernel to stop reporting I have no 
keyboard at boot(I KNOW!!).

I finally located where kb gets initialized.

Is it this simple just to undef this in /include/linux/pc_keyb.h

#define KBD_REPORT_TIMEOUTS             /* Report keyboard timeouts */

I have read code through, and it appears the right thing to do (and it's so 
simple I am in doubt it is this easy), but I am loath to try it in case the 
box doesn't come up and I will have to fart around getting out monitor and kb 
and move my sofa for access and stuff...

Thanks for any help.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
