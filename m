Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDSWzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDSWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWDSWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:55:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:262 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751316AbWDSWzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:55:07 -0400
Date: Thu, 20 Apr 2006 00:55:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060419225506.GG25047@stusta.de>
References: <20060418220715.GO11582@stusta.de> <20060419051355.GI4825@rhun.haifa.ibm.com> <20060419180724.GD25047@stusta.de> <20060419184957.GK4825@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419184957.GK4825@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 09:49:58PM +0300, Muli Ben-Yehuda wrote:
> On Wed, Apr 19, 2006 at 08:07:24PM +0200, Adrian Bunk wrote:
> 
> > Which file under Documentation/ are you referring to?
> 
> virt_to_bus() and bus_to_virt() appear in several files, in particular
> DMA-mapping.txt and IO-mapping.txt.

DMA-mapping.txt exlicitely states it's planned with 
virt_to_bus/bus_to_virt, and IO-mapping.txt starts with:

<--  snip  -->

[ NOTE: The virt_to_bus() and bus_to_virt() functions have been
        superseded by the functionality provided by the PCI DMA
        interface (see Documentation/DMA-mapping.txt).  They continue
        to be documented below for historical purposes, but new code
        must not use them. --davidm 00/12/12 ]

<--  snip  -->

Patches to update Documentation/ are always welcome, but these two files 
already explicitely mention virt_to_bus/bus_to_virt, as deprecated, so I 
still don't see any urgent action required.

> Cheers,
> Muli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

