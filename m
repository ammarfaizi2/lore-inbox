Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTBXU3X>; Mon, 24 Feb 2003 15:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTBXU3X>; Mon, 24 Feb 2003 15:29:23 -0500
Received: from havoc.daloft.com ([64.213.145.173]:48353 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267459AbTBXU3U>;
	Mon, 24 Feb 2003 15:29:20 -0500
Date: Mon, 24 Feb 2003 15:39:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Xinwen Fu <xinwenfu@cs.tamu.edu>
Cc: Paul Rolland <rol@as2917.net>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: how to force 10/100 speeds in Linux if both ethtool and mii-tool don't work
Message-ID: <20030224203929.GA15677@gtf.org>
References: <002101c2dbd5$6fabc400$3f00a8c0@witbe> <Pine.SOL.4.10.10302241218050.2913-100000@dogbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.10.10302241218050.2913-100000@dogbert>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 12:27:31PM -0600, Xinwen Fu wrote:
> Hi, 
> 	For one of my machines, both ethtool and mii-tool don't work. Here
> are the error messages:
> 
> (mii-tool)
> SIOCGMIIPHY on 'eth0' failed: invalid argument
> .............................................
> SIOCGMIIPHY on 'eth7' failed: invalid argument
> no MII interfaces found
> 
> (ethtool eth0)
> setting for eth0:
> no data available

What NIC driver are you using?

It is the responsibility of the NIC driver to provide this information.

	Jeff




