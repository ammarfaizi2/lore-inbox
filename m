Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVBHAvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVBHAvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVBHAvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:51:38 -0500
Received: from outbound01.telus.net ([199.185.220.220]:51878 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S261363AbVBHAvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:51:14 -0500
Message-ID: <1107823873.42080d01c42df@webmail.telus.net>
Date: Mon,  7 Feb 2005 16:51:13 -0800
From: gl34@telus.net
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.9 failure
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1-cvs
X-Originating-IP: 209.52.208.124
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
 
On a K6-2 box the 2.6.9 kernel starts to load : "Loading...." then the PC 
resets. 
The kernel compiled and everything installed OK. Lilo is OK.  I've tried four 
times different configs with the same result. Box resets. My 2.4.28 kernel 
works OK. 
I've tried rm'ing and re-unpacking the 2.6.9 source and starting afresh.  Box 
resets.
 
The only clue, if that's what it is, is when I tried to upgrade module-init-
tools 
and quota-tools I got an error, can't find ../asm-generic/errno.h. True 
enough, 
there's no ../asm-generic dir in the includes. The closest is  ../mach-
generic. 
And there *is* a errno.h in the include files. So I just made an ../asm-
generic dir 
and put a copy of errno.h in it. No luck.
 
-Gil





