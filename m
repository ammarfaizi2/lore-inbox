Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVCTJtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVCTJtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVCTJtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:49:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1176 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262058AbVCTJtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:49:07 -0500
Date: Sun, 20 Mar 2005 10:48:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Change proc file permissions with sysctls
In-Reply-To: <1111298903.1930.99.camel@cube>
Message-ID: <Pine.LNX.4.61.0503201047260.24849@yvahk01.tjqt.qr>
References: <1111278162.22BA.5209@neapel230.server4you.de> <1111298903.1930.99.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The permissions of files in /proc/1 (usually belonging to init) are
>> kept as they are.  The idea is to let system processes be freely
>> visible by anyone, just as before.  Especially interesting in this
>> regard would be instances of login.  I don't know how to easily
>> discriminate between system processes and "normal" processes inside
>> the kernel (apart from pid == 1 and uid == 0 (which is too broad)).
>> Any ideas?

As a side note, I have not experienced any problems when also "hiding" system 
processes by making e.g. /proc/1 mode 0700.



Jan Engelhardt
-- 
