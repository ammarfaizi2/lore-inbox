Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132456AbQLQLP5>; Sun, 17 Dec 2000 06:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132493AbQLQLPj>; Sun, 17 Dec 2000 06:15:39 -0500
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:64335 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id <S132456AbQLQLPf>; Sun, 17 Dec 2000 06:15:35 -0500
Date: Sun, 17 Dec 2000 11:46:38 +0100
Message-ID: <vines.sxdD+Ca7DuA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: tasknames
X-Incognito-SN: 3029
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi list,

lately i wrote a programm to find a PID(-list) for a given name. I found it confusing that the tasks are not having a propper form of name registration.
The field int task_struct the field comm is restricted to 16 chars. Longer names can only be identified with the 'cmdline' entry from the procfs. But not every task set it e.g. kflushd and friends.

I would call to force all programm to fill the 'cmdline' entry.
Does any programm use the comm entry ? ( i dont talk about ps, print is not a use in this sense). if not the 'cmdline' could replace the comm field. It would be more flexable.
(and its already there in mm_struct)


walter

ps: i am not a memeber of this list



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
