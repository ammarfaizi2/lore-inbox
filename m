Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFNSK3>; Fri, 14 Jun 2002 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSFNSK2>; Fri, 14 Jun 2002 14:10:28 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:52920 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313181AbSFNSK2>;
	Fri, 14 Jun 2002 14:10:28 -0400
Message-ID: <3D0A316F.6010701@candelatech.com>
Date: Fri, 14 Jun 2002 11:09:51 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Lincoln Dale <ltd@cisco.com>, jamal <hadi@cyberus.ca>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <5.1.0.14.2.20020612224038.0251bd08@mira-sjcm-3.cisco.com> 	<5.1.0.14.2.20020614100914.01adca48@mira-sjcm-3.cisco.com> <1024069878.20676.1.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Hemminger wrote:

> It sounds like what you want is socket accounting which works like
> process accounting.  I.e when a socket lifetime ends, put out a record
> with number of packets/bytes sent/received.


Runtime is much more interesting to me.  However, if you are keeping
enough information to do the accounting as you suggest, then it would
be trivial to make it available incrementally over the life of the
socket.

Billing is not the only interesting aspect of this.  It is also good for
any program trying to dynamically tune or understand the lower-level
characteristics of a particular routing path or interface.

Ben




-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


