Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315348AbSDWVvN>; Tue, 23 Apr 2002 17:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315351AbSDWVvM>; Tue, 23 Apr 2002 17:51:12 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:2256 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S315348AbSDWVvM>; Tue, 23 Apr 2002 17:51:12 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: [PATCH] page coloring for 2.4.18 kernel
Date: Tue, 23 Apr 2002 23:51:00 +0200
X-Mailer: KMail [version 1.4]
Cc: Robert Love <rml@tech9.net>, George Anzinger <george@mvista.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204232351.01415.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Page coloring for 2.4.18+ isn't preempt save?

It gave ~10% speedup for memory intensive apps on my single  1 GHz Athlon II 
SlotA (0,18µm, L2 512K) but look the system hard from time to time. Nothing 
in the logs.

I've changed the patch for 2.4.19-pre7 + vm3 + latest rml-O(1) + preempt.

Thanks,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

