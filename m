Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271868AbRH1ST0>; Tue, 28 Aug 2001 14:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271869AbRH1STQ>; Tue, 28 Aug 2001 14:19:16 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:50948 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271868AbRH1SS7>; Tue, 28 Aug 2001 14:18:59 -0400
Date: Tue, 28 Aug 2001 19:18:45 +0100
From: Matthew Hambley <matthew@aether.demon.co.uk>
To: linux-kernel@vger.kernel.org
Message-ID: <411e3db14a.matthew@aether.demon.co.uk>
X-Organization: Beyond the Reality Barrier
User-Agent: Messenger-Pro/2.50a (RemoteNB/1.50) (RISC-OS/4.02)
Subject: ip_dynaddr problem wirh 2.4.9
X-Editor: Zap 1.44 (24 Jul 2001) [TEST 7], ZapEmail 0.26 (14 Jun 2001) test-2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently indulged in a marathon compile-a-thon (glibc 2.2.3, X 4.1.0 and
all the things they are dependent on) and at the end of this I found that
ppp was no longer dialling on demand correctly.  What appears to be
happening is that ip_dynaddr isn't working properly.  The first connection
(the one which initiated the dial) fails.

Prior to noticing the problem with ppp I also upgraded to 2.4.9 of the
kernel.  So my question is this, is there a known problem with ip_dynaddr
or is it more likely to be a problem with the default configuration of DNS
lookups in glibc as I have seen suggested elsewhere?

-- 
(\/)atthew Hambley ----------------\ If something's worth doing it's worth
                                    \ doing badly until you can learn to
matthew@aether.demon.co.uk           \ do it well.
http://www.aether.demon.co.uk/        \-----------------------------------

