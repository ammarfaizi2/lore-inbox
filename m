Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbUCZIHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUCZIHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:07:54 -0500
Received: from sea2-dav24.sea2.hotmail.com ([207.68.164.81]:11 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264033AbUCZIHw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:07:52 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: <linux-kernel@vger.kernel.org>
References: <DAV6695HfqR77bieLYC00007982@hotmail.com> <40632922.7080804@nortelnetworks.com>
Subject: Re: proxy arp behaviour
Date: Fri, 26 Mar 2004 09:07:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV24tRc0JFaTi00010373@hotmail.com>
X-OriginalArrivalTime: 26 Mar 2004 08:07:24.0957 (UTC) FILETIME=[5F690CD0:01C41309]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Marco Berizzi wrote:
> 
> > eth1 configuration is here:
> > 
> > ifconfig eth1 10.77.77.1 broadcast 10.77.77.3 netmask 255.255.255.252
> > ip route del 10.77.77.0/30 dev eth1
> > ip route add 172.17.1.0/24 dev eth1
> > 
> > echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp
> > 
> > Hosts connected to eth1 are all 172.17.1.0/24.
> > The linux box is now replying to arp requests
> > that are sent by 172.17.1.0/24 hosts on the eth1
> > network segment.
> 
> Arp requests for what IP addresses?

The linux box is replying to arp requests for 172.17.1.0/24, sent
by 172.17.1.0/24 systems (windoze 2000 and Linux 2.4.25).
