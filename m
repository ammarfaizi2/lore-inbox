Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWC3Qfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWC3Qfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWC3Qfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:35:53 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:57052 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932225AbWC3Qfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:35:52 -0500
Message-ID: <34784.128.237.233.65.1143736552.squirrel@128.237.233.65>
Date: Thu, 30 Mar 2006 11:35:52 -0500 (EST)
Subject: cannot get clean 2.4.20 kernel to compile
From: "George P Nychis" <gnychis@cmu.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked its sign, and no matter what I try I cannot get it to compile.

I do a make mrproper, I then do make dep which is fine, but then i try "make bzImage modules modules_install", selecting all the defaults, and get an SMP header error:
http://rafb.net/paste/results/QzIq7v86.html

I then disable SMP support and get:
http://rafb.net/paste/results/muYA9t12.html

I even tried using my config from the 2.4.32 kernel which works perfectly fine, and I also get the sched errors.

I'd greatly appreciate any help.  Using a different kernel is not an option, I need to use the 2.4.20 kernel for a project that a module was written and tested on.

Thanks!
Geirge

