Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269923AbUJHAHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269923AbUJHAHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJHAHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:07:21 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:35457 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S269929AbUJHAEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:04:43 -0400
Message-ID: <4165D997.1060006@candelatech.com>
Date: Thu, 07 Oct 2004 17:04:39 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>	<41658C03.6000503@nortelnetworks.com>	<015f01c4acbe$cf70dae0$161b14ac@boromir>	<4165B9DD.7010603@nortelnetworks.com>	<20041007150035.6e9f0e09.davem@davemloft.net>	<4165C20D.8020808@nortelnetworks.com>	<20041007152634.5374a774.davem@davemloft.net>	<4165C58A.9030803@nortelnetworks.com> <20041007154204.44e71da6.davem@davemloft.net> <4165D0D7.8040608@nortelnetworks.com>
In-Reply-To: <4165D0D7.8040608@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't a lot of NICs do UDP checksum in hardware, basically for free?

At least in this case there would be no penalty for select()
looking for the corrupted packet?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

