Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSHFTnX>; Tue, 6 Aug 2002 15:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHFTnW>; Tue, 6 Aug 2002 15:43:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315442AbSHFTnW>;
	Tue, 6 Aug 2002 15:43:22 -0400
Date: Tue, 6 Aug 2002 12:44:16 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: <root@chaos.analogic.com>, <linux-kernel@vger.kernel.org>,
       <abraham@2d3d.co.za>
Subject: Re: ethtool documentation
In-Reply-To: <3D502611.26B28B8E@nortelnetworks.com>
Message-ID: <Pine.LNX.4.33L2.0208061242300.10089-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Chris Friesen wrote:

| "Richard B. Johnson" wrote:
|
| > Because of this, there is no such thing as 'unused eeprom space' in
| > the Ethernet Controllers. Be careful about putting this weapon in
| > the hands of the 'public'. All you need is for one Linux Machine
| > on a LAN to end up with the same IEEE Station Address as another
| > on that LAN and connectivity to everything on that segment will
| > stop. You do this once at an important site and Linux will get a
| > very black eye.
|
| Can't we already tell cards (some of them anyway) what MAC address to use when
| sending packets?  This doesn't overwrite the EEPROM, but it does last for that
| session...

Sure, and that doesn't violate any IEEE Ethernet standards.
Locally Administered Addresses are allowed.
Just make sure that they don't conflict with other addresses.

-- 
~Randy

