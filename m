Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUE2PvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUE2PvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUE2PvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:51:16 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:60290 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265227AbUE2PvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:51:15 -0400
Message-ID: <40B8A37D.1090802@myrealbox.com>
Date: Sat, 29 May 2004 07:51:41 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Gigabit Kconfig problems with yesterday's update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one machine with a gigabit NIC which I updated today from Linus'
bk tree.

The problem is that I was not asked if I wanted the 'new' gigabit
support and therefore the tg3 support was dropped from my new .config.

I edited .config by hand and deleted any mention of ethernet support --
and only then did 'make oldconfig' ask me the right questions.

Also: the phrase (10 or 100Mbit) should be deleted from the 'Ethernet'
menu item since it implies (wrongly) that the item is not needed for
gigabit support.


Thanks!
