Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293235AbSCAKLP>; Fri, 1 Mar 2002 05:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310422AbSCAKIu>; Fri, 1 Mar 2002 05:08:50 -0500
Received: from ns.suse.de ([213.95.15.193]:44818 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310452AbSCAKFq>;
	Fri, 1 Mar 2002 05:05:46 -0500
Date: Fri, 1 Mar 2002 11:05:45 +0100
From: Dave Jones <davej@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre2 -- video1394.o -- depmod:  virt_to_bus_not_defined_use_pci_map
Message-ID: <20020301110545.C7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3C7F4080.7060802@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7F4080.7060802@megapathdsl.net>; from miles@megapathdsl.net on Fri, Mar 01, 2002 at 12:49:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:49:04AM -0800, Miles Lane wrote:
 > Dave, do you have a fix for this in your tree?
 > 
 > depmod: *** Unresolved symbols in 
 > /lib/modules/2.5.6-pre2/kernel/drivers/ieee1394/video1394.o
 > depmod: 	virt_to_bus_not_defined_use_pci_map

 A fix no, a workaround yes.
 People who don't want to/havent time/know-how to fix these
 can just undef CONFIG_DEBUG_OBSOLETE in .config for my tree.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
