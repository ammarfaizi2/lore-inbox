Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTIEMqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTIEMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:46:25 -0400
Received: from mail.netbeat.de ([62.208.140.19]:21006 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S262544AbTIEMqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:46:24 -0400
Subject: Re: 2.6.0-test4-mm6
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: text/plain
Message-Id: <1062766000.2081.11.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 14:46:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like I got the reason for X not starting:

pseudo terminals can't be acquired and only two consoles are running.

-> X11 can't get console Vt7
-> pppd doesn't work either

This definitely worked with -mm5.

I tried on both Thinkpad R40 2722 and a Elitegroup MB+ Athlon XP1800
System with Debian SID. I didn't use devfs.


Jan

-- 
Jan Ischebeck <mail@jan-ischebeck.de>

