Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbTGCXsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTGCXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 19:48:22 -0400
Received: from jefm-152.dfw.tx.bbnow.net ([24.219.87.152]:42114 "EHLO
	quickening.home") by vger.kernel.org with ESMTP id S265527AbTGCXsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 19:48:22 -0400
Message-ID: <3F04C427.5010708@tvmax.net>
Date: Thu, 03 Jul 2003 19:02:47 -0500
From: Kyle Davenport <kdd@tvmax.net>
Organization: Davenport Consulting
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bttv-driver.c syntax error in 2.4.21
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make bzImage fails with:
bttv-driver.c:564: parse error before `35468950'

There is clearly an equal sign missing on this line.  I verified the 
source linux-2.4.21.tar.bz2 and also its md5sum.  I unpacked it on 2 
different systems (RH6.2 & RH8) with same result.

Kyle
kdd@quickening.hn.org

