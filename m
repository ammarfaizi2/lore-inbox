Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282138AbRKWMvr>; Fri, 23 Nov 2001 07:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282135AbRKWMv3>; Fri, 23 Nov 2001 07:51:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27083 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282133AbRKWMvP>;
	Fri, 23 Nov 2001 07:51:15 -0500
Date: Fri, 23 Nov 2001 15:48:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [bug] broken loopback fs in 2.4.15-ish kernels?
Message-ID: <Pine.LNX.4.33.0111231546190.18284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just noticed that rpm -i kernel-2.4.9-13.i386.rpm does not work anymore
because a corrupted initrd gets created by mkinitrd. It smelled like
pagecache corruption so i did not experiment much. This was with
2.4.15-pre9. Once i booted back into a 2.4.13-based kernel and re-did the
rpm -i, the initrd was created correctly.

things are pretty recent:

 [root@mars root]# rpm -q mkinitrd
 mkinitrd-3.2.6-1
 [root@mars root]# rpm -q rpm
 rpm-4.0.3-1.03

anyone seeing anything similar?

	Ingo

