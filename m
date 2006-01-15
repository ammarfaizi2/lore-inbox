Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWAORFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWAORFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWAORFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:05:09 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:48824 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932065AbWAORFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:05:07 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun, 15 Jan 2006 18:05:03 +0100
To: linux-kernel@vger.kernel.org
Cc: dtor@mail.ru
Subject: Synclient (synaptics driver) broken since 2.6.15-rc1 (shm related)
Message-Id: <20060115170502.6012822AEF3@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
since 2.6.15-rc1 synclient on my laptop returns
Can't access shared memory area. SHMConfig disabled?
due to
shmget(23947, 296, 0)                   = -1 ENOENT (No such file or directory)
where 23947 is SHM_SYNAPTICS.

Any suggestions, please?

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
