Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVH3Nbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVH3Nbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVH3Nbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:31:35 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:39824 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750903AbVH3Nbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:31:34 -0400
Message-ID: <43145FB5.6080300@gentoo.org>
Date: Tue, 30 Aug 2005 14:31:33 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shemminger@osdl.org
Cc: Steve Kieu <haiquy@yahoo.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050830122937.79855.qmail@web53605.mail.yahoo.com>
In-Reply-To: <20050830122937.79855.qmail@web53605.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding on, please reply-to-all in future.

Steve Kieu wrote:
> Hi all,
> 
> I have "fixed" the problem in a very wierd way.Reading
> your post I thought maybe when removing the driver
> itself it set some bit incorrectly. Then I decided to
> do:
> 
> Boot with init=/bin/bash  so bypass all other things.
> modprobe skge
> 
> run ifconfig eth0 ip_num  up
> 
> 
> ping  a host
> 
> then while pinging hit Ctrl+Alt+Del key to hot reboot
> the system.
> 
> I still see the light at the hub lits. Now I boot to
> winXP and as I expected , it worked!
> 
> No I boot 2.6.11 and it worked, so the problem resolve
> but I am tooooo scared to run 2613 now :-)
> 
> Hope this information helps debuging the driver.
> 
> Thanks.
> 
> S.KIEU
