Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132560AbRDQGIh>; Tue, 17 Apr 2001 02:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDQGI1>; Tue, 17 Apr 2001 02:08:27 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:15889 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S132560AbRDQGIV>;
	Tue, 17 Apr 2001 02:08:21 -0400
Message-ID: <3ADBE40A.A455AD29@candelatech.com>
Date: Mon, 16 Apr 2001 23:34:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 802.1Q VLAN patch for 2.4.4-pre3 & 2.2.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just updated the VLAN patches slightly.  The 2.2 series patch
did not change, but is now known to patch into 2.2.19 w/out
trouble.

The 2.4 series patch was briefly tested against 2.4.4-pre3 and
seems to be working OK.

The changes are:
  Allow MAC change to work correctly by recognizing PACKET_HOST
  This should help those folks that like to change the MAC address
  on their VLANs to be different than the underlying ethernet device.

  Compile fix for using VLANs as a module.

Comments, suggestions, patches and praise are all welcome! :)

Details, download, & mailing list at:
http://scry.wanfear.com/~greear/vlan.html

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
