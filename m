Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRCBWGJ>; Fri, 2 Mar 2001 17:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRCBWFy>; Fri, 2 Mar 2001 17:05:54 -0500
Received: from ns.dkik.dk ([194.234.39.2]:31240 "HELO dkik.dk")
	by vger.kernel.org with SMTP id <S129554AbRCBWFl> convert rfc822-to-8bit;
	Fri, 2 Mar 2001 17:05:41 -0500
Message-ID: <003a01c0a364$e95cbd00$5f01a8c0@worm>
From: "Christian Worm Mortensen" <worm@dkik.dk>
To: <lartc@mailman.ds9a.nl>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>
Subject: [ANNOUNCE] New version of the WRR network scheduler
Date: Fri, 2 Mar 2001 23:05:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just released a new version of the WRR scheduler supporting the 
2.4 kernels besides 2.2 as always . The WRR scheduler is an extension 
to the Traffic Control/network bandwidth management part of the Linux 
kernels. The scheduler was developed to support distributing bandwidth 
on a shared Internet connection fairly between local machines.

Further comments:

* As a default all local machines will get equally much
  of the bandwidth if they have sufficient demand. This
  is obtained by doing so-called weighted round robin (wrr)
  scheduling.
* It is possible to give machines transferring much data
  over a long or short period of time less bandwidth.
* It can work on a bridge, a router or on a firewall.
* Supports accounting locally generated masqgraded packets
  to the correct local machine.
* On the WRR home page an extension is available which
  includes patches for Squid and the Nec socks5 proxy servers
  so that proxied packets can also be accounted to the
  correct local machine.
* Includes a configuration file based set of scripts that
  will setup everything without changing your basic network
  setup. The scripts will allow you to shape both incoming
  and outgoing traffic.


Christian

