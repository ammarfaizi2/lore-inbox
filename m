Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbULRKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbULRKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 05:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbULRKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 05:15:09 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:19585 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262084AbULRKPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 05:15:04 -0500
Message-ID: <41C40326.3070303@free.fr>
Date: Sat, 18 Dec 2004 11:15:02 +0100
From: Charles-Henri Collin <charlie.collin@free.fr>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ip=dhcp problem...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got the following problem with linux 2.6.8.1:
I'm nfs-rooting a diskless client with kernel parameter ip=dhcp.
My dhcpd.conf  has a "option domain-name-servers X.X.X.X;" statement and 
"get-lease-hostnames true;"
Now when the diskless clients boot, no name-server configured and they 
cant resolv.
dmesg gives me, for instance:

IP Config: Complete:
    device=eth0, addr=192.168.0.237, mask=255.255.255.0, gw=192.168.0.1,
    host=clientFSB-237.fsb.net, domain=fsb.net, nis-domain=FSBnis,
    boot-server=192.168.0.254, rootserver=92.168.0.254, rootpath=

So as you can see, everything is almost set up, except a nameserver!
Has anyone heard about that problem before? Are there any fixes?

regards,
C COLLIN


