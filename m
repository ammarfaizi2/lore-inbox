Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSHJSAX>; Sat, 10 Aug 2002 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSHJSAX>; Sat, 10 Aug 2002 14:00:23 -0400
Received: from dsl-64-129-199-125.telocity.com ([64.129.199.125]:22238 "HELO
	descola.net") by vger.kernel.org with SMTP id <S317117AbSHJSAV>;
	Sat, 10 Aug 2002 14:00:21 -0400
Date: Sat, 10 Aug 2002 11:04:05 -0700
From: "Darrell A. Escola" <darrell-kernel@descola.net>
To: Nilanjan Bhowmik <nilu@iomachine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.19: Tulip network card does not sync with Dumb 10/100 Linksys 8 port Etherfast switch
Message-ID: <20020810180405.GA31193@descola.net>
Mail-Followup-To: "Darrell A. Escola" <darrell-kernel@descola.net>,
	Nilanjan Bhowmik <nilu@iomachine.com>, linux-kernel@vger.kernel.org
References: <000b01c24092$d0d0c160$63c8a8c0@arunachal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c24092$d0d0c160$63c8a8c0@arunachal>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Data point:

I have a server and firewall using 2.4.19-pre2-ac4 with Linksys LNE100TX nic's

firewall is 6x86 on Intel 430VX uptime 146 days
server is PII on Intel 440BX uptime 83 days

both report the nic as:
Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)

both autonegotiate 100 full duplex with a Seimens 5 port 10/100 switch

Maybe Linksys used different chipsets in their LNE100TX, or some change
since 2.4.19-pre2-ac4 is a problem


On Sat, Aug 10, 2002 at 01:24:42PM -0400, Nilanjan Bhowmik wrote:
> This happend on a working machine. After I have upgraded to 2.4.19, tulip
> driver
> will not work.  Only way to sync it is loading the driver couple of times
> and that too
> it will sync at 10/half.
> 
> This is working fine with the 2.4.7-10 stock redhat kernel.
> 
...
> 00:10.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys
> EtherFast 10/100] (rev 25)
> 
> nilu@calculator.nilu.net-5->cat /proc/ioports
...
> 1400-14ff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
>   1400-14ff : tulip
...
This matches my /proc/ioports entry for tulip

If you want any more info, just ask...

Darrell
