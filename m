Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268893AbTBZTsf>; Wed, 26 Feb 2003 14:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268894AbTBZTsf>; Wed, 26 Feb 2003 14:48:35 -0500
Received: from clavin.cs.tamu.edu ([128.194.130.106]:59026 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S268893AbTBZTsd>;
	Wed, 26 Feb 2003 14:48:33 -0500
Date: Wed, 26 Feb 2003 13:58:43 -0600 (CST)
From: Xinwen Fu <xinwenfu@cs.tamu.edu>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Paul Rolland <rol@as2917.net>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: mii-tool works - but need compiled again
In-Reply-To: <20030224203929.GA15677@gtf.org>
Message-ID: <Pine.SOL.4.10.10302261355210.25240-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that my TimeSys OS uses a different library from the standard
Linux. Following Mark Hahn's suggestion, what we need do is to recompile
mii-tool.

Thanks all!


Xinwen Fu


On Mon, 24 Feb 2003, Jeff Garzik wrote:

> On Mon, Feb 24, 2003 at 12:27:31PM -0600, Xinwen Fu wrote:
> > Hi, 
> > 	For one of my machines, both ethtool and mii-tool don't work. Here
> > are the error messages:
> > 
> > (mii-tool)
> > SIOCGMIIPHY on 'eth0' failed: invalid argument
> > .............................................
> > SIOCGMIIPHY on 'eth7' failed: invalid argument
> > no MII interfaces found
> > 
> > (ethtool eth0)
> > setting for eth0:
> > no data available
> 
> What NIC driver are you using?
> 
> It is the responsibility of the NIC driver to provide this information.
> 
> 	Jeff
> 
> 
> 
> 
> 

