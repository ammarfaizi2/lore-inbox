Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133050AbRDRHZy>; Wed, 18 Apr 2001 03:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133047AbRDRHZp>; Wed, 18 Apr 2001 03:25:45 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:59370 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S133046AbRDRHZd>; Wed, 18 Apr 2001 03:25:33 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B271DD@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: change_mtu boundary checking error
Date: Wed, 18 Apr 2001 00:25:26 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But Ethernet is not only for IP, what about other protocols ?

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, April 17, 2001 3:41 PM
To: shmulik.hen@intel.com
Cc: linux-net@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: change_mtu boundary checking error


> Now, the high boundary seemed reasonable (ETH_FRAME_LEN - ETH_HLEN =
> ETH_DATA_LEN) which gives 1500, but why is the low boundary set to 68 ?
> According to my calculations, it should have been ETH_ZLEN - ETH_HLEN
which
> gives 46.

The IPv4 minimum MTU is 68 bytes. Below that not all frames can be delivered


