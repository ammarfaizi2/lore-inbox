Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbRDVWnd>; Sun, 22 Apr 2001 18:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135422AbRDVWnN>; Sun, 22 Apr 2001 18:43:13 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:53508 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135413AbRDVWnB>;
	Sun, 22 Apr 2001 18:43:01 -0400
Message-ID: <3AE36485.5D54E871@candelatech.com>
Date: Sun, 22 Apr 2001 16:08:53 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compile problem with 2.4.4-pre6 (net_pcmcia.o not found in link)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I configure PCMCIA out of the build, the build will not link,
because the linker is still looking for the net_pcmcia.o file.

If I say yes for PCMCIA and enable a single module, it works.

compile configuration available if someone would like to see it.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
