Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRHPF6O>; Thu, 16 Aug 2001 01:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271490AbRHPF6F>; Thu, 16 Aug 2001 01:58:05 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:15792 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S271486AbRHPF5r>;
	Thu, 16 Aug 2001 01:57:47 -0400
Message-ID: <3B7B60E7.E5ACB4A7@candelatech.com>
Date: Wed, 15 Aug 2001 22:57:59 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Question on IOCTL hooks.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, my VLAN code creates a file: /proc/net/vlan/config,
and I have attached an IOCTL hook to that file, such that when
an ioctl call is done on that file, my method is called...

However, davem wants VLAN to be able to function w/out the
/proc fs.  So, I need to know how to ensure my IOCTL
code can be called on any (or some other) file.

Can someone suggest a piece of code or documentation that
I should look at for the 'right way' to do this?

Also, any suggestions as to how to pick an IOCTL that is
guaranteed not to conflict with someone else's IOCTL?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
