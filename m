Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVC2Uhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVC2Uhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVC2Ugu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:36:50 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:59052 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261391AbVC2Ug3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:36:29 -0500
Message-ID: <4249BC48.6080608@candelatech.com>
Date: Tue, 29 Mar 2005 12:36:24 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
 (Solved)
References: <42421FF2.7050501@candelatech.com> <20050324081003.GA23453@xi.wantstofly.org> <42431734.3030905@candelatech.com>
In-Reply-To: <42431734.3030905@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For posterity's sake:

The problem is evidently a hardware problem, and I'll have to
return the board to the manufacturer so they can solder on another
part.

So, if you want to use 4-port NICs in slot-5 of the SuperMicro X6DVA-EG
board, then purchase the X6DVA-4G instead, as the X6DVA-EG will NOT work.

Actually, anything that tries to use the 3rd PCI function will probably fail
as well...

Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

