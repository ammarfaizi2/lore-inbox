Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTE0RBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTE0RBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:01:14 -0400
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:37542 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id S263944AbTE0RBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:01:13 -0400
Message-ID: <3ED39CEF.9070805@candelatech.com>
Date: Tue, 27 May 2003 10:14:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Corbett, David" <corbett@intrusion.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: sis900 802.1q VLAN Overlength Packets
References: <636A9B29EA94BC4194D844C27A3B1AAB03FC7D91@mercury.intrusion.com>
In-Reply-To: <636A9B29EA94BC4194D844C27A3B1AAB03FC7D91@mercury.intrusion.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corbett, David wrote:
> Does anybody know if the sis900 can be used with 802.1q VLANs, where
> the 4 bytes of tag information do not cause the driver to drop
> packets with (# of payload bytes) > 1496 ? I've searched the Internet
> and archives, but have found no definitive answer. I updated the
> sis900 driver from the 2.4.9-34 kernel to the one in the 2.4.20 kernel
> but I see no difference. I found information about allowing jumbo
> frames, but I am not sure if this is the best approach. 
> 
> If I need to ask this question elsewhere, please tell me. 

Allowing jumbo frames on the receive path may fix the problem.  There may
be folks on the VLAN mailing list that can help you.  There is also
a FAQ that has some info on various drivers.  Both are linked from
this page:  http://www.candelatech.com/~greear/vlan.html

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


