Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUDMFcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 01:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbUDMFcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 01:32:19 -0400
Received: from [203.145.183.39] ([203.145.183.39]:3595 "EHLO
	globaledgesoft.com") by vger.kernel.org with ESMTP id S263325AbUDMFcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 01:32:16 -0400
Message-ID: <007501c3b895$efd46d60$110610ac@krupaxp>
From: "krupa" <krupa@globaledgesoft.com>
To: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
References: <000001c42116$7d00fb70$0200080a@panic>
Subject: Fragmentation issue
Date: Tue, 2 Dec 2003 11:04:20 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-MDRemoteIP: 172.16.6.17
X-Return-Path: krupa@globaledgesoft.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Anybody.........could you help me.

Steps followed.

1. insmod module.o              // inserting module
2. iwconfig eth1 essid <access point>  // associating with AP
3. iwconfig eth1 frag 512               // setting fragmentation
4. ping <ip of access point> -s 700

The problem here is ..............when I ping to that AP with packect size
more that Frag value,69 packets it will send then it will hang.

How to overcome this


----- Original Message -----
From: "Shawn Starr" <shawn.starr@rogers.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'Len Brown'" <len.brown@intel.com>; <linux-kernel@vger.kernel.org>;
<netdev@oss.sgi.com>
Sent: Tuesday, April 13, 2004 10:46 AM
Subject: RE: [BUG][2.6.5 final][e100/ee100pro] NETDEV_WATCHDOG
Timeout -Related to i2c interface?


> Might be, I have since not had any issues with timeouts. Though, I don't
> know where it is doing this. It is an IBM machine so some things are
> proprietary.
>
> -----Original Message-----
> From: Jeff Garzik
> Sent: Sunday, April 11, 2004 05:02 PM
> To: Shawn Starr
> Cc: 'Len Brown'; linux-kernel@; netdev@
> Subject: Re: [BUG][2.6.5 final][e100/ee100pro] NETDEV_WATCHDOG Timeout
> -Related to i2c interface?
>
>
> Shawn Starr wrote:
> > Ok, this is strange, I put in an external 10/100 PRO S Adaptor, and im
> > not getting anymore eth0 timeouts, I would only get eth0 timeouts on
> > the ONBOARD nic if I enabled the lm80 sensor driver.. I don't know
> > what to say, the onboard nic would work fine without lm80 being
> > loaded?
> >
> > Is there some sort of race condition that the onboard 10/100 PRO is
> > doing ?
>
> If i2c is killing the network, sounds like it's diddling something on
> the motherboard it shouldn't...
>
> Jeff
>

