Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRAXBdD>; Tue, 23 Jan 2001 20:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130613AbRAXBcw>; Tue, 23 Jan 2001 20:32:52 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:48651 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S130335AbRAXBce>;
	Tue, 23 Jan 2001 20:32:34 -0500
Message-ID: <3A6E4040.86D750D7@candelatech.com>
Date: Tue, 23 Jan 2001 19:38:56 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weis <djweis@sjdjweis.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: changing mac address of eth alias
In-Reply-To: <Pine.LNX.4.21.0101231927060.23337-100000@www.sjdjweis.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weis wrote:
> 
> what would be required to make the mac address of aliases changable,
> specifically for something like vrrp that shares a mac address among
> machines.
> 
> dave

Not sure you can do that, but you could use an 802.1Q vlan patch
and set up two different VLANs.  You can now change the MAC
address on a VLAN with my patch: http://scry.wanfear.com/~greear/vlan.html

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
