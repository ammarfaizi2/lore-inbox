Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269466AbTGJPp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269423AbTGJPp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:45:57 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:62338 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S269451AbTGJPnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:43:47 -0400
Date: Fri, 11 Jul 2003 01:58:02 +1000
From: CaT <cat@zip.com.au>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, pekkas@netcore.fi
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
Message-ID: <20030710155802.GF1722@zip.com.au>
References: <20030710154302.GE1722@zip.com.au> <20030711.005542.04973601.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711.005542.04973601.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 12:55:42AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> > ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
> >  ip route add ::/0 via 3ffe:8001:000c:ffff::36 
> > RTNETLINK answers: Invalid argument
> 
> This is not bug, but rather misconfiguration;
> you cannot use prefix::, which is mandatory subnet routers 
> anycast address, as unicast address.

Ok. I'm a bit lost then. What should the line be then? To me the above
makes sense (and used to work), but then I'm not that experienced with
IPv6...

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
