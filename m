Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSHAVSf>; Thu, 1 Aug 2002 17:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSHAVSf>; Thu, 1 Aug 2002 17:18:35 -0400
Received: from nemesis.systems.pipex.net ([62.241.160.8]:29588 "EHLO
	nemesis.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S317115AbSHAVSd>; Thu, 1 Aug 2002 17:18:33 -0400
Subject: 2.4.19-rc5: boot failure with IO-APIC built in
From: Alastair Stevens <alastair@camlinux.co.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020720194403.B21534@lostlogicx.com>
References: <1027026004.13704.6.camel@dolphin.entropy.net>
	<20020718202641.A1645@lostlogicx.com> 
	<20020720194403.B21534@lostlogicx.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Aug 2002 22:21:57 +0100
Message-Id: <1028236918.1625.5.camel@dolphin.entropy.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers:

Just an observation with the latest kernel here. I previously had
problems compiling kernels (eg 2.4.19-rc2-ac2) *unless* both LOCAL-APIC
and IO-APIC were configured in. This is now solved, in that I can
compile with or without IO-APIC.

However, I just built 2.4.19-rc5 with them *both* selected, and it
wouldn't boot. My system is an Athlon XP / Abit KR7A mboard / Via KT266A
running RH 7.3 - am I doing something wrong?

I have now rebuilt with just LOCAL-APIC and without IO-APIC and it's
running like a baby :-)

Hope this is helpful....
Cheers
Alastair

-- 
 \\ Alastair Stevens                        Cambridge
  \\ Technical Director                        /     \..-^..^...
   \\                                          |Linux solutions \
    \\ 01223 813774                            \     /........../
     \\ www.camlinux.co.uk                      '-=-'
      --

