Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAYGGG>; Thu, 25 Jan 2001 01:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYGF4>; Thu, 25 Jan 2001 01:05:56 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:53256 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135501AbRAYGFp>;
	Thu, 25 Jan 2001 01:05:45 -0500
Message-ID: <3A6FD1D4.61F3CD38@candelatech.com>
Date: Thu, 25 Jan 2001 00:12:20 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to determine what driver belongs to eth0 (ethX)?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write a server that is able to run specific
diags against various ethernet drivers, knowing only the
interface name (ie eth0).

Can anyone think of a reasonably easy way to tell what driver
 (and thus what diag-code), to run against a particular interface?

This information is spit out at boot time, but processing the dmesg
log is almost too much of a hack for me to bear!!

These are the values I'm currently planning on probing and setting:

Link Speed (10/100, full/half, auto-negotiate)

After these are satisfied, then other things can be added as desired.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
