Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUJ2Dbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUJ2Dbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUJ2Dbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:31:53 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:40975 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261280AbUJ2Dbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 23:31:51 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>, <parker@citywireless.net>
Subject: RE: ICMP ttl-exceeded packets not sourced correctly
Date: Thu, 28 Oct 2004 20:31:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGECJPGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20041029010721.GA25817@core.citynetwireless.net>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 28 Oct 2004 20:08:18 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 28 Oct 2004 20:08:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Say you have a router, and it's multihomed to two different isp's,
> say cogentco.com and qwest.net as your upstreams.
> On your cogent interface, you have the ip address on the /30
> assigned by cogent,
> with reverse dns being blahblah.demarc.cogentco.com on the qwest
> interface.
> Same story with qwest, with reverse dns being whatever.qwest.net.
> Now let's say someone out on the internet with ip address of 1.1.1.1 runs
> a traceroute into your network and his incoming path to your
> network comes over qwest.
> Your router's hop should source its ICMP ttl-exceeded code (the
> traceroute hop) on
> its qwest /30 ip address, because thats where the traceroute got
> triggered.
> ICMP ttl-exceeded code's response should not be originated from
> the interface
> holding the route, but should be origianted from the interface
> that got hit
> with the traceroute.

	Why? If the same machine has two IP addresses, reaching one is the same as
reaching the other.

	DS


