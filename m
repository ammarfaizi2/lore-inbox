Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264835AbRFSXu4>; Tue, 19 Jun 2001 19:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbRFSXup>; Tue, 19 Jun 2001 19:50:45 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:9925 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264835AbRFSXu3>;
	Tue, 19 Jun 2001 19:50:29 -0400
Message-ID: <3B2FE544.A0DEB568@candelatech.com>
Date: Tue, 19 Jun 2001 16:50:28 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: net.agent and ifconfig (RH 7.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running my VLAN test, which creates 4000 VLAN interfaces,
sets their IP/mask, and then later tears them down...

However, my box is seeing 300 processes running and a load
of around 47.00.  Most of these processes are 'ifconfig'
and net.agent.  I am not running ifconfig in my script, so
I assume net.agent is.  Needless to say, my test is running
real slow...

I am wondering if this is a RH only thing, or if it is found
across all 2.4 distributions...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
