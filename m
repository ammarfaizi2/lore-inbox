Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSBVAVB>; Thu, 21 Feb 2002 19:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288834AbSBVAUl>; Thu, 21 Feb 2002 19:20:41 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:21253 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288830AbSBVAUh>; Thu, 21 Feb 2002 19:20:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 21 Feb 2002 16:22:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] /dev/epoll for 2.4.17 && 2.5.5 ...
Message-ID: <Pine.LNX.4.44.0202211616230.938-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes :

*) ported to 2.4.17 && 2.5.5

*) timeout in ms ( thx to Per Bergqvist )

*) implemeted poll() on /dev/epoll fd ( thx to Per Bergqvist )

*) EP_ISPOLLED now like DP_ISPOLLED

*) used wait_queue_active() instead of ->sleepers ( thx to Niel Lehman )



Files :

http://www.xmailserver.org/linux-patches/nio-improve.html
http://www.xmailserver.org/linux-patches/ep_patch-2.4.17-0.28.diff
http://www.xmailserver.org/linux-patches/ep_patch-2.5.5-0.28.diff




- Davide


