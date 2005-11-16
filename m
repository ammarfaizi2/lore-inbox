Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbVKPXQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVKPXQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKPXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:16:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030564AbVKPXQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:16:50 -0500
Date: Thu, 17 Nov 2005 00:16:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
Message-ID: <20051116231650.GR5735@stusta.de>
References: <20051116194414.GA14953@fargo> <20051116.115141.33136176.davem@davemloft.net> <20051116201020.GA15113@fargo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051116201020.GA15113@fargo>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 09:10:20PM +0100, David Gómez wrote:
> Hi David,
> 
> On Nov 16 at 11:51:41, David S. Miller wrote:
> > From: David Gómez <david@pleyades.net>
> > Date: Wed, 16 Nov 2005 20:44:14 +0100
> > 
> > > It's impossible to enable the U32 classifier in QoS submenu, to use it
> > > with the "tc" application. In fact there are 23 :-/ options and suboptions
> > > that are missing from the configuration because it seems that the Kconfig
> > > file is broken.
> > 
> > I can enable this just fine by using "make config", making
> > sure to enable CONFIG_NET_SCHED, then CONFIG_NET_CLS_BASIC,
> > and then the necessary classifiers (including U32) are offered
> > to be enabled.
> 
> Sorry for not giving more details. I'm using make menuconfig
> in a 2.6.14 kernel After selecting CONFIG_NET_SCHED and CONFIG_NET_CLS_BASIC
> i don't see new options, the last option visible is NET_CLS_ROUTE4.

And if you select NET_CLS_ROUTE4, this should automatically select 
NET_CLS_ROUTE.

Are you saying that after enabling NET_CLS_ROUTE4, the option 
NET_CLS_ROUTE is not set in your .config?

> thanks,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

