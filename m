Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316063AbSENVVK>; Tue, 14 May 2002 17:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316064AbSENVVJ>; Tue, 14 May 2002 17:21:09 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:12739 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S316063AbSENVVJ>;
	Tue, 14 May 2002 17:21:09 -0400
Date: Tue, 14 May 2002 23:21:06 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody (Long Message)
Message-ID: <20020514212106.GA19037@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andre LeBlanc <ap.leblanc@shaw.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox> <20020514202912.GA18544@outpost.ds9a.nl> <000c01c1fba2$1779da60$2000a8c0@metalbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 04:50:13PM -0700, Andre LeBlanc wrote:

> Heres the ifconfig before pinging:

> eth0 Link encap:Ethernet HWaddr 00:E0:29:94:CA:BC
> UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:6 errors:0 dropped:0 overruns:0 carrier:0

(...) and after:

> eth0 Link encap:Ethernet HWaddr 00:E0:29:94:CA:BC
> UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:6 errors:0 dropped:0 overruns:0 carrier:0

The kernel did not even try to send anything out to eth0. Can you check your
routing? In other words, do you even have a route pointing to 192.168.0.1?

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
