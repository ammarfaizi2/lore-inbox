Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274579AbRITRrQ>; Thu, 20 Sep 2001 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274581AbRITRrG>; Thu, 20 Sep 2001 13:47:06 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:32181 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274579AbRITRq5>;
	Thu, 20 Sep 2001 13:46:57 -0400
Message-ID: <3BAA2BA8.34873B27@candelatech.com>
Date: Thu, 20 Sep 2001 10:47:20 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pre12 fails to compile:  wakeup_bdflush issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used the .config from RH's roswell beta.

I get this error:

sysrq.c:35: conflicting types for 'wakeup_bdflush'
/root/linux/include/linux/fs.h:1347: previous declaration of 'wakeup_bdflush'

One says it takes a void argument, the other  an int......

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
