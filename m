Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbTCJTUv>; Mon, 10 Mar 2003 14:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbTCJTUu>; Mon, 10 Mar 2003 14:20:50 -0500
Received: from [199.26.153.9] ([199.26.153.9]:42335 "EHLO PONYX.fourelle.com")
	by vger.kernel.org with ESMTP id <S261436AbTCJTUs>;
	Mon, 10 Mar 2003 14:20:48 -0500
Message-ID: <3E6CE8C9.3060805@fourelle.com>
Date: Mon, 10 Mar 2003 11:34:33 -0800
From: Adam Scislowicz <adams@fourelle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.20] system freezes Intel e1000(included & 4.4.19) & bonding(20030207,
 active-backup mode)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2003 19:31:20.0318 (UTC) FILETIME=[A097B9E0:01C2E73B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
    Tyan S2723 (dual XEON)
    [both NICs onboard]
    Intel Pro/1000 MT Gigabit Adaptor (primary ethernet)
    Intel EEPro/100 (secondary)

Software:
    Linux 2.4.20
    bonding patch 20030207
    included e1000 driver and the 4.4.19 release from intel

Upon reconfig of the bonding interface the system freezes. I have not 
been so lucky yo see a panic. I do know that it occurs when I run ifconfig.

If I do not use bonding, but do load both ethernet drivers I do not 
experience any lockups.

Is anyone else using 2.4.20 bonding in combination w/ the e1000 or 
better yet the Tyan S2723?

thank u all,
/)dam.. .  . D o n ' t   S t o p
plz CC: adams@fourelle.com on any replys

