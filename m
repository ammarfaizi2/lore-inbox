Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269897AbUJGXdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269897AbUJGXdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269929AbUJGXdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:33:07 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:6530 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269897AbUJGX3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:29:20 -0400
Message-ID: <4165D0D7.8040608@nortelnetworks.com>
Date: Thu, 07 Oct 2004 17:27:19 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: martijn@entmoot.nl, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>	<41658C03.6000503@nortelnetworks.com>	<015f01c4acbe$cf70dae0$161b14ac@boromir>	<4165B9DD.7010603@nortelnetworks.com>	<20041007150035.6e9f0e09.davem@davemloft.net>	<4165C20D.8020808@nortelnetworks.com>	<20041007152634.5374a774.davem@davemloft.net>	<4165C58A.9030803@nortelnetworks.com> <20041007154204.44e71da6.davem@davemloft.net>
In-Reply-To: <20041007154204.44e71da6.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> So people who improperly use select() with blocking sockets get punished
> in a different way, with half the performance compared to today?

Yes.  Rather than having an app that doesn't work at all in the case of 
corrupted packets, they get half the performance.

Chris
