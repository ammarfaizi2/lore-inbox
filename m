Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbTCVKB2>; Sat, 22 Mar 2003 05:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbTCVKB2>; Sat, 22 Mar 2003 05:01:28 -0500
Received: from smtp2.songnet.fi ([194.100.2.122]:63809 "EHLO smtp2.songnet.fi")
	by vger.kernel.org with ESMTP id <S262087AbTCVKB1>;
	Sat, 22 Mar 2003 05:01:27 -0500
Message-ID: <3E7C3707.4E583F8@clinet.fi>
Date: Sat, 22 Mar 2003 12:12:23 +0200
From: Tomi Hakala <tomi.hakala@clinet.fi>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre5] ethernet bonding caused system lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Last night I experienced total system lockup when I added second NIC to
bond0 group, no OOPS or anything, system stopped to respond immediatiately.

I had system running about 30 minutes with only one slave for bond0 before
I did "ifenslave bond0 eth1" which then resulted the lockup. I haven't had
yet time to test this again but I had bonding running with same config on
2.4.20.

System is a Dell PowerEdge 2600 with two Intel PRO/1000 NIC's.

-- 
Tomi Hakala
tomi.hakala@clinet.fi
