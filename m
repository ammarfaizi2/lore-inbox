Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbULRMKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbULRMKk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 07:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbULRMKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 07:10:40 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:5371 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262171AbULRMKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 07:10:24 -0500
Message-ID: <41C41E2D.3010306@free.fr>
Date: Sat, 18 Dec 2004 13:10:21 +0100
From: Charles-Henri Collin <charlie.collin@free.fr>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip=dhcp problem...
References: <41C40326.3070303@free.fr> <1103371154.12078.61.camel@tux.rsn.bth.se>
In-Reply-To: <1103371154.12078.61.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson a écrit :

>On Sat, 2004-12-18 at 11:15, Charles-Henri Collin wrote:
>  
>
>>Hi,
>>
>>I've got the following problem with linux 2.6.8.1:
>>I'm nfs-rooting a diskless client with kernel parameter ip=dhcp.
>>My dhcpd.conf  has a "option domain-name-servers X.X.X.X;" statement and 
>>"get-lease-hostnames true;"
>>Now when the diskless clients boot, no name-server configured and they 
>>cant resolv.
>>dmesg gives me, for instance:
>>
>>IP Config: Complete:
>>    device=eth0, addr=192.168.0.237, mask=255.255.255.0, gw=192.168.0.1,
>>    host=clientFSB-237.fsb.net, domain=fsb.net, nis-domain=FSBnis,
>>    boot-server=192.168.0.254, rootserver=92.168.0.254, rootpath=
>>
>>So as you can see, everything is almost set up, except a nameserver!
>>Has anyone heard about that problem before? Are there any fixes?
>>    
>>
>
>The fix is to make sure you have a nameserver in your /etc/resolv.conf
>The kernel has no idea how to resolve names into addresses. That's a
>userspace thing. I'm not sure if you can extract the dhcp info from the
>kernel after the boot, otherwise you'll just have to run a userspace
>dhcp client, I use dhclient.
>
>  
>
i should put a /etc/resolv.conf.... but i dont want, for "dark reasons" ;)
if i have a /etc/resolv.conf, what's the point in querying the dhcp 
server for a nameserver???
i thought this would set linux a nameserver in case no /etc/resolv.conf 
was find.
btw, i can't dhclient has i'm nfs-rooting. doing this breaks my 
connection with the nfs server and i lose / !!!!!
i'm working on it.
thanks anyway

regards,
 COLLIN


