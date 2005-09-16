Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbVIPNgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbVIPNgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbVIPNgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:36:10 -0400
Received: from bay106-f27.bay106.hotmail.com ([65.54.161.37]:58136 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965298AbVIPNgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:36:08 -0400
Message-ID: <BAY106-F27CF4B237502C97B89C9B3AB910@phx.gbl>
X-Originating-IP: [65.54.161.206]
X-Originating-Email: [alaadalghan@hotmail.com]
From: "Alaa Dalghan" <alaadalghan@hotmail.com>
To: users@openswan.org, linux-crypto@nl.linux.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linux-security-module@mail.wirex.com, netdev@vger.kernel.org
Subject: Double Encryption
Date: Fri, 16 Sep 2005 13:36:04 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Sep 2005 13:36:04.0361 (UTC) FILETIME=[95BE8F90:01C5BAC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have an OpenSWAN (2.3.1) box accepting ipsec tunnels from wireless 
(802.11) clients equipped with Linux and Windows XP.
Wireless clients are using the openswan gateway to exchange data securely 
between each other, so there are no direct tunnels between client 
themselves.
The gateway is doing the routing job fine but there is a security gap when 
it has to decrypt data sent by a given client and then reencrypt it before 
sending it to the ultimate destination. It may be better not to expose the 
data in the clear at the gateway.

I know this can be solved by using double encryption (tunnel inside a  
tunnel), but, I wonder if  there is a better alternative?
I was thinking of using L2TP/IPSec tunnels instead of pure IPSec tunnels, 
and then, maybe I can use L2TP encryption to encrypt end-to-end and IPSec 
encryption to encrypt end-to-gateway. Would this work?

I appreciate any help and advices.

Alaadin

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

