Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278218AbRJWUfQ>; Tue, 23 Oct 2001 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278221AbRJWUfG>; Tue, 23 Oct 2001 16:35:06 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:26292 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S278218AbRJWUfA>;
	Tue, 23 Oct 2001 16:35:00 -0400
Message-ID: <3BD5D496.3FEA316@candelatech.com>
Date: Tue, 23 Oct 2001 13:35:34 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Tulip Mailing List <tulip@scyld.com>
Subject: Small bug with ZYNX 4-Port NIC (Tulip driver)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the tulip driver that comes default with 2.4.13-pre5:

There seems to be a problem with the ZYNX 4-port NIC.
It auto-negotiates and brings it's link up, but it's
advertise bits are set to (only) 10bt-FD.  If I force the
bits to 10/100 FD/HD (all 4 set, in other words), then the
NIC briefly reports this setting (while LINK is DOWN), but
as soon as it completes it's autonegotiation, the advert
bits are once again set to 10bt-FD.

I do NOT see this problem on the D-LINK 4-port NIC or the
EEPRO NICs I've been testing with....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
