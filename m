Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVJERMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVJERMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVJERMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:12:09 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:53059 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1030264AbVJERMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:12:07 -0400
Message-ID: <43440915.7060405@emc.com>
Date: Wed, 05 Oct 2005 13:10:45 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Evgeny Rodichev <er@sai.msu.su>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode) (resend:
 v0.22)
References: <20050930053600.F3B821CDD0@lns1058.lss.emc.com> <4341E420.6070808@pobox.com> <Pine.GSO.4.63.0510051912230.10241@ra.sai.msu.su> <434407A2.6010605@pobox.com>
In-Reply-To: <434407A2.6010605@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.5.18
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Evgeny Rodichev wrote:
> 
>> On Mon, 3 Oct 2005, Jeff Garzik wrote:
>>
>>> applied
>>>
>>
>> This patch leads to freeze with Marvell MV88SX6041 4-port SATA II 
>> PCI-X Controller (rev 03), as I wrote already
>> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0510.0/0203.html)
>>
>> It is impossible to reboot the system without  harware reset (after 
>> modprobe).
> 
> 
> I'm betting a temporary workaround should be to disable CONFIG_SMP.
> 
> The first attached patch (patch.1) fixes one of the lockups.  The second 
> attached patch (patch.2) should fix all the lockups, but that's just a 
> guess, and it's a very ugly patch.
> 
> Note that patch.2 depends on patch.1.


I'm testing a more extensive patch that should address these issues.  I 
had sent something similar to the patches above to several users and it 
fixed the lockup and brought 60xx to a working condition.

BR

PS...please CC the linux-ide mailing list in the future with these 
problem reports, I am not subscribed to lkml.
