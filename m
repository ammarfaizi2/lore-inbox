Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbSJJAh0>; Wed, 9 Oct 2002 20:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSJJAh0>; Wed, 9 Oct 2002 20:37:26 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:51093 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S262650AbSJJAh0>; Wed, 9 Oct 2002 20:37:26 -0400
Date: Thu, 10 Oct 2002 01:42:37 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: Yuji Sekiya <sekiya@sfc.wide.ad.jp>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021010014237.F8102@edi-view1.cisco.com>
References: <20021010002902.A3803@edi-view1.cisco.com> <20021009.162438.82081593.davem@redhat.com> <uu1jv9o3j.wl@sfc.wide.ad.jp> <20021009.164504.28085695.davem@redhat.com> <ur8ez9n8d.wl@sfc.wide.ad.jp> <20021010010439.C8102@edi-view1.cisco.com> <uptuj9mkq.wl@sfc.wide.ad.jp> <20021010012108.E8102@edi-view1.cisco.com> <uofa39lm9.wl@sfc.wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <uofa39lm9.wl@sfc.wide.ad.jp>; from sekiya@sfc.wide.ad.jp on Thu, Oct 10, 2002 at 09:35:26AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 09:35:26AM +0900, Yuji Sekiya wrote:
> OK. I have assigned fe80:1910::10/64 link-local address to
> USAGI linux box and tried to ping ipv6.
> 
> Target IPv6 address: fe80:1910::10
> Repeat count [5]:
> Datagram size [100]:
> Timeout in seconds [2]:
> Extended commands? [no]:
> Output Interface: FastEthernet4/1
> Type escape sequence to abort.
> Sending 5, 100-byte ICMP Echos to FE80:1910::10, timeout is 2 seconds:
> !!!!!
> Success rate is 100 percent (5/5), round-trip min/avg/max = 1/2/4 ms
> 
> Oct 10 09:27:35: IPV6: source FE80::201:64FF:FEA3:ED55 (local)
> Oct 10 09:27:35:       dest FE80:1910::10 (FastEthernet4/1)
> Oct 10 09:27:35:       traffic class 224, flow 0x0, len 64+16, prot 58, hops 255, originating
> Oct 10 09:27:35: IPv6: Sending on FastEthernet4/1

Well what do you know?  At least one implementation supports that type of
config.

Anyway,  I as said in an earlier email,  do whatever you want.  I just
considered that change to be dubious.

DF
