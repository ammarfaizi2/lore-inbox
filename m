Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUDOCPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 22:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUDOCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 22:15:31 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:39709 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263588AbUDOCPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 22:15:30 -0400
To: ZI ZHOU <zhouzi@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HELP ! Why my dev->hard_start_xmit get called three times for one ping packet?
References: <20040415012536.61202.qmail@web12505.mail.yahoo.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 14 Apr 2004 19:15:29 -0700
In-Reply-To: <20040415012536.61202.qmail@web12505.mail.yahoo.com>
Message-ID: <52oepu7zr2.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Apr 2004 02:15:29.0796 (UTC) FILETIME=[860E2C40:01C4228F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ZI> After I configure the ethernet interface(it's a PCI card
    ZI> plugged in my debian PC), I run command ' ping -c 1
    ZI> 192.168.0.100', (the interface is configured with IP address
    ZI> 192.168.0.35), I used smartbit to look at the wire and found 3
    ZI> ping packets. From the debugging info, I can see
    ZI> dev->hard_start_xmit is called three times, the DMA engine
    ZI> seems to be acting correctly, and each time hard_start_xmit is
    ZI> invoked the skb address is different. How can this happen? 

Are any of the 3 packets actually arp packets?

 - Roland
