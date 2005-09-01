Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVIAVp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVIAVp5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbVIAVp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:45:57 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:27664 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1030392AbVIAVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:45:56 -0400
Message-ID: <43177681.5040507@symas.com>
Date: Thu, 01 Sep 2005 14:45:37 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050829 SeaMonkey/1.1a
MIME-Version: 1.0
To: Steve Kieu <haiquy@yahoo.com>
CC: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050901212110.19192.qmail@web53605.mail.yahoo.com>
In-Reply-To: <20050901212110.19192.qmail@web53605.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve Kieu wrote:
>> Is this the correct summary of the problem
>> scenarios.
>> Assume each one starts from cold boot (power off).
>>
>> * 2.6.13(skge) boot                    => Good
>> * 2.6.13(sk98lin) boot                 => Good
>> * 2.6.13 + SK version of sk98lin       => Good
>> * XP boot                              => Good 
>>     
> XP boot: No good if before 2.6.13 runs on the hardware
> and do the normal shuttdown or reboot or power off.
>
> The same for all linux kernel before 2.6.13 (tested
> 2.6.12, 2.6.11)
>   
It's worth noting that most PCs today with ATX power supplies really 
only go into a "Soft Off" state, which is probably why the anomaly 
persists across a power off. You should also test if powering off and 
removing the power plug will allow booting to XP to work.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

