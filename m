Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUDHPcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUDHPcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:32:00 -0400
Received: from tartutest.cyber.ee ([193.40.6.70]:15876 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S261897AbUDHPbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:31:16 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
In-Reply-To: <200404071222.21397.rjwysocki@sisk.pl>
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BBAb0-00081U-EF@rhn.tartu-labor>
Date: Wed, 07 Apr 2004 13:47:50 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RJW> FYI, I've just had a keyboard lockup on a Toshiba laptop (Satellite 1400-103) 
RJW> with the 2.6.5 kernel.

I haven't tried 2.6.5 on my Toshiba yet but I had a similar problem on
my PC (Duron 600 with VIA KT-133 chipset). I was running X and the
keyboard forze, even Numlock didn't work. First time I solved it by
ending the session by mouse, this got me back to another session on VT7.
Later I had the problem on VT7 and solved it by logging in remotely and
doing "chvt 1" and "chvt 7" as root. Third time chvt didn't help either
but removing and replugging the keyboard (PS/2) worked. Mouse was USB.

-- 
Meelis Roos (mroos@linux.ee)
