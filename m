Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSGMRRv>; Sat, 13 Jul 2002 13:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSGMRRu>; Sat, 13 Jul 2002 13:17:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55792 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315214AbSGMRRt>; Sat, 13 Jul 2002 13:17:49 -0400
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020713121946.14953A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1020713121946.14953A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 19:28:40 +0100
Message-Id: <1026584920.13885.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 17:21, Bill Davidsen wrote:
> In the absense of the proxy_arp flag, I would not expect that reply,
> the IP is not on that NIC. Before I "fix" that, is this intended
> behaviour for some reason? Will I break something if I add check logic?
> Is there something in /proc/sys/net/ipv4 I missed which will avoid this
> response?

Your suspicion and the reality don't match. The RFC's leave the
situation unclear and some OS's do either. Newer 2.4 has arpfilter which
can be used to control what actually occurs

