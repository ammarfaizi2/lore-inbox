Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314792AbSD2D70>; Sun, 28 Apr 2002 23:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314794AbSD2D70>; Sun, 28 Apr 2002 23:59:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53942 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314792AbSD2D7Z>;
	Sun, 28 Apr 2002 23:59:25 -0400
Date: Sun, 28 Apr 2002 20:49:11 -0700 (PDT)
Message-Id: <20020428.204911.63038910.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <467685860.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Sun, 28 Apr 2002 22:28:06 +0200
   
   > Please don't bother posting the results, we know what will happen.
   
   I think your solution is ok for 2.5 but not for 2.4. On the 2.4 series it would be easier to
   add a flag which is set if the driver is VLAN ready.

Will you at least listen to what my proposed solution is?
It has precisely the same effect your proposal has.

Let me say it for millionth time:

Networking sets "can't VLAN" by default in device flags,
if device driver clear it we can do VLAN.  So by default
device is marked as not VLAN capable.

This is exactly the behavior you are asking for.  There
is no fundamental difference between your scheme and mine
except that I am being required to retype a description
of mine a million times.
