Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUGGW55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUGGW55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUGGW55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:57:57 -0400
Received: from pernis.its.UU.SE ([130.238.4.153]:19638 "EHLO pernis.its.uu.se")
	by vger.kernel.org with ESMTP id S265661AbUGGW5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:57:37 -0400
Message-ID: <40EC7FB1.4020906@update.uu.se>
Date: Thu, 08 Jul 2004 08:26:49 +0930
From: =?ISO-8859-1?Q?Lars_Hagstr=F6m?= <lars@update.uu.se>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: forcedeth on MSI K8N Neo Platinum
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-kernel and Carl-Daniel,

I have just put together a system with a MSI K8N Neo Platinum 
motherboard, and I've been having trouble getting the network up and 
running. The chipset is the NVIDIA nForce 3 250Gb.

I'm using gentoo, and have compiled kernel 2.6.7 (gentoo-dev-sources, if 
you're familiar with gentoo) with the forcedeth-bk4 and 
forcedeth_gigabig_try19 patches. I have compiled the forcedeth driver as 
a module (It is the 10/100 forcedeth driver that is patched to handle 
1000, right?).
When I try to start up the network I get the following messages in my 
syslog:
   eth0: phy init failed to autoneg
   eth0: no link during initialization
(I had the NIC connected to a switch at the time, in case that is what 
is meant by the "no link" bit)
Is there something simple that I missed, like module parameters, or is 
this a more complicated issue?

Tonight I will try to enable debugging in the code, to see if I can get 
some more information for you. I would be more than willing to help you 
out with any testing you need.

Is there anything else I can do to help?
Lars

