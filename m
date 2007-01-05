Return-Path: <linux-kernel-owner+w=401wt.eu-S1030371AbXAEJJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbXAEJJ6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbXAEJJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:09:58 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:47832 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030364AbXAEJJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:09:56 -0500
Message-ID: <459E15E1.3010708@blueyonder.co.uk>
Date: Fri, 05 Jan 2007 09:09:53 +0000
From: Sid Boyce <g3vbv@blueyonder.co.uk>
Reply-To: g3vbv@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.19 and up to 2.6.20-rc2 Ethernet problems x86_64
References: <459A7D46.5000509@blueyonder.co.uk> <200701021159.24945.lenb@kernel.org> <459AE34D.8040709@blueyonder.co.uk> <200701030117.31737.lenb@kernel.org>
In-Reply-To: <200701030117.31737.lenb@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
>> ..same problem with 2.6.20-rc3. Last worked with 
>> 2.6.19-rc6-git12, so it was 2.6.19 where it failed.
>>     
>
>
>   
>> Attaching both case1 normal, case2 acpi=noirq. With acpi=noirq ethernet 
>> doesn't get configured, route -n says it's an Unsupported operation, 
>> ifconfig only shows for localhost, ifconfig eth0 192.168.10.5 also 
>> complains of a config error.
>>     
>
> It seems that the "acpi=noirq" (and probably also the acpi=off) case
> is simply an additional broken case, not a success case to compare to.
>
> The thing we really want to compare is dmesg and /proc/interrupts
> from 2.6.19-rc6-git12, and the broken current release.
> Perhaps you can put that info in the bug report when you file it.
>
> thanks,
> -Len
>
>
>
>   
2.6.19-rc6-git12 fails in exactly the same way, from /var/log/messages 
it seems 2.6.19-rc6 19/11/06 first saw the problem, details later when I 
boot 2.6.19-rc5.
If I boot an affected kernel with the SuSEfirewall2 enabled and then 
stop the firewall, the problems goes away.
Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


