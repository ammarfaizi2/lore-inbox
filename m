Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTBXSXa>; Mon, 24 Feb 2003 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTBXSWH>; Mon, 24 Feb 2003 13:22:07 -0500
Received: from clavin.cs.tamu.edu ([128.194.130.106]:7093 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S267443AbTBXSRZ>;
	Mon, 24 Feb 2003 13:17:25 -0500
Date: Mon, 24 Feb 2003 12:27:31 -0600 (CST)
From: Xinwen Fu <xinwenfu@cs.tamu.edu>
To: Paul Rolland <rol@as2917.net>
cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: how to force 10/100 speeds in Linux if both ethtool and mii-tool
 don't work
In-Reply-To: <002101c2dbd5$6fabc400$3f00a8c0@witbe>
Message-ID: <Pine.SOL.4.10.10302241218050.2913-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
	For one of my machines, both ethtool and mii-tool don't work. Here
are the error messages:

(mii-tool)
SIOCGMIIPHY on 'eth0' failed: invalid argument
.............................................
SIOCGMIIPHY on 'eth7' failed: invalid argument
no MII interfaces found

(ethtool eth0)
setting for eth0:
no data available

I tried some other parameters and go similar results.

What else can we do to force the speed?


Xinwen Fu


On Mon, 24 Feb 2003, Paul Rolland wrote:

> > 	How can I force the speeds of the two cards at 10Mbps 
> > or 100Mbps? Where can I find the parameter list to do such forcing?
> > 
> Have a look at :
>  - mii-tool
>  - ethtool
> depending on your card.
> 
> Regards,
> Paul
> 
> 
> 

