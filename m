Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278679AbRJ1VbC>; Sun, 28 Oct 2001 16:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278680AbRJ1Vaw>; Sun, 28 Oct 2001 16:30:52 -0500
Received: from smtp.chello.fr ([212.186.224.11]:22185 "EHLO frmta00.chello.fr")
	by vger.kernel.org with ESMTP id <S278679AbRJ1Vai>;
	Sun, 28 Oct 2001 16:30:38 -0500
Message-ID: <3BDC7945.9166B90D@chello.fr>
Date: Sun, 28 Oct 2001 22:31:49 +0100
From: "Fabrice Lorrain (home)" <fabrice.lorrain@chello.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-althair i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: arp cache tuning in 2.4.x (x >= 10)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC, I'm not on the list)
(a CC to lorrain@univ-mlv.fr would be appreciated to)
Hi,

For quite some time now, I have "Neighbour table overflow." on
one of our router (serving more than 1000 boxes).

A bunch of google search gave me to answer :
1 - playing with /proc/sys/net/ipv4/neigh/default/gc_thres*
2 - configure CONFIG_ARPD and find an user-space arp daemon.

Can any of you guys give more explanations on both solutions?
Mainly : 
- what are sane value for 1),
- is 2 really a "sane" solution (from Configure.help :
"This code is experimental and also obsolete").

Thanks,

	Fab
