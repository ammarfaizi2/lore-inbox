Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUCRSSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUCRSSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:18:31 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:34245 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262834AbUCRSS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:18:29 -0500
From: nmag@softhome.net
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack, NIC counters limit and kernel 2.4.24
Date: Thu, 18 Mar 2004 11:18:28 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [200.37.137.89]
Message-ID: <courier.4059E7F4.0000251E@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I have a server with Debian woody stable (gcc 2.95.4, kernel 2.4.24, Intel 
Petium IV 2.4 GHz, 512 RAM, NIC: D-Link) working as gateway and, I have a 
problem with kernel, see the following: 

Mar 17 10:13:23 blackmarsh kernel: LIST_DELETE: ip_conntrack_core.c:302 
`&ct->tuplehash[IP_CT_DIR_REPLY]'(ddf5c414) not in &ip_conntrack_hash[hr]. 

After this message, the system be froze. I have noted that it only happen 
when the NIC counters reach the limit count (RX TX), all the traffic of my 
network, use it, the traffic is very high, I need restart the server in some 
nights (once on a week) before the NIC counter reach the limits... 

Somebody could tell me if the new kernel patch (2.4.25) repairs this error? 

thanks a lot! 

 --
nmag only
GPG public key: 0xA024A03F [http://pgp.mit.edu/]
GNU/Linux Registered User #312624 

