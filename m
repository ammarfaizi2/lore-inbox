Return-Path: <linux-kernel-owner+w=401wt.eu-S1030318AbXAKMvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbXAKMvt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbXAKMvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:51:49 -0500
Received: from mx10.go2.pl ([193.17.41.74]:43533 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030316AbXAKMvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:51:48 -0500
Date: Thu, 11 Jan 2007 13:53:43 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Bernhard Schmidt <berni@birkenwald.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPv6] PROBLEM? Network unreachable despite correct route
Message-ID: <20070111125343.GB3561@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110002352.GA31743@obelix.birkenwald.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-2007 01:23, Bernhard Schmidt wrote:
> On Tue, Jan 09, 2007 at 08:36:24PM +0100, Bernhard Schmidt wrote:
...
>> I'm having a really ugly problem I'm trying to pinpoint, but failed so
>> far. I'm neither completely convinced it is not related to my local
>> setup(s), nor do I have any clue how this might be caused.
...
> I managed to pull ip -6 route, ip -6 neigh and ip -6 addr while the box
> was not responding:
> 
> ip -6 route:
> 2001:4ca0:0:f000::/64 dev eth0  proto kernel  metric 256  expires 86322sec mtu 1500 advmss 1440 fragtimeout 4294967295
> fe80::/64 dev eth0  metric 256  expires 21225804sec mtu 1500 advmss 1440 fragtimeout 4294967295
> ff00::/8 dev eth0  metric 256  expires 21225804sec mtu 1500 advmss 1440 fragtimeout 4294967295
> default via fe80::2d0:4ff:fe12:2400 dev eth0  proto kernel  metric 1024  expires 1717sec mtu 1500 advmss 1440 fragtimeout 64
> unreachable default dev lo  proto none  metric -1  error -101 fragtimeout 255

Did you analyze this dev lo warning? 

Regards,
Jarek P.
