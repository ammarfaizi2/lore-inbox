Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284370AbRLXDZG>; Sun, 23 Dec 2001 22:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284398AbRLXDYz>; Sun, 23 Dec 2001 22:24:55 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:39065 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S284370AbRLXDYo>;
	Sun, 23 Dec 2001 22:24:44 -0500
Message-ID: <3C269FF1.5040402@candelatech.com>
Date: Sun, 23 Dec 2001 20:24:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
Subject: Re: [PATCH] eepro100 - need testers
In-Reply-To: <E167w6n-0001dz-00@fenrus.demon.nl> <3C0D54DF.4E897B70@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried this patch against the 2.4.17 kernel.  I was able to
completely freeze my D815EEA2 motherboard based computer by trying
to copy a large directory over NFS.  The machine is connected to a
10bt HUB, and this setup has shown lockups before with various
eepro100 drivers.  The e100 seems to work fine in this setup...

An older eepro driver (the one with RH's 2.4.9-13 kernel) does not
lock up the machine, but I do see incessant wait-for-cmd-done-timeout
messages, and the network is basically un-usable.

On other machines, connected to a 100bt-FD switch, the new patch
seems to work just fine, btw.

The eepro lockup is repeatable, so let me know if there is any
information I can get for you that will help.

Thanks,
Ben

Tim Hockin wrote:

> This patch was developed here to resolve a number of eepro100 issues we
> were seeing. I'd like to get people to try this on their eepro100 chips and
> beat on it for a while.
> 
> volunteers?


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


