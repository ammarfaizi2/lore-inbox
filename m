Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbVINUSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbVINUSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbVINUSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:18:23 -0400
Received: from bay106-f29.bay106.hotmail.com ([65.54.161.39]:21734 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932716AbVINUSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:18:21 -0400
Message-ID: <BAY106-F29965CB20274069D3A5BA5AB9F0@phx.gbl>
X-Originating-IP: [65.54.161.206]
X-Originating-Email: [alaadalghan@hotmail.com]
From: "Alaa Dalghan" <alaadalghan@hotmail.com>
To: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, linux-security-module@mail.wirex.com,
       netdev@vger.kernel.org
Subject: VPN server over windows XP
Date: Wed, 14 Sep 2005 20:18:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 14 Sep 2005 20:18:21.0193 (UTC) FILETIME=[73975790:01C5B969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello everyone,

I am trying to setup a windows xp machine as a vpn server that accepts 
multiple ipsec tunnels from other windows xp machines.

My restrictions are the following:

1- I need to set the vpn server on windows XP (not windows 2000 server, nor 
2003, nor ISA server, etc.)

2- I need to use tunnel mode ipsec

3- The vpn server should accept MULTIPLE vpn tunnels.

The first problem I faced is that windows xp does not support ipsec tunnel 
mode between 2 xp machines. It only supports transport mode which is not 
what I want.
To overcome this lack of IP tunneling I tried to use the built-in tunneling 
capabilities such as PPTP and L2TP/ipsec, and it worked. But the problem 
here is that a windows xp can not accept more than ONE SINGLE incoming 
connection at a time, and I need multiple connections.

I think the solution could be one of the following:

1-Installing a third party FREE vpn server (or L2TP server) on windows XP. 
If you know one please tell me.

2-Importing some features from windows 2000 server or 2003 server (some 
executables or services or plugins that enable xp to run as a vpn server and 
accept multiple connections). If you know what to import please tell me.

3- Installing a pure IP tunneling solution on windows xp so that it can be 
combined with ipsec encryption to yield tunnel mode encryption.

I appreciate any help,

Alaadin

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

