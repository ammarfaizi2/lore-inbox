Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWDMRcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWDMRcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDMRcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:32:12 -0400
Received: from mtaout4.012.net.il ([84.95.2.10]:62894 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S932338AbWDMRcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:32:11 -0400
Date: Thu, 13 Apr 2006 20:31:21 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
 V2
In-reply-to: <20060413160712.GG24769@pb15.lixom.net>
To: Olof Johansson <olof@lixom.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Message-id: <20060413173121.GJ10412@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060413020559.GC24769@pb15.lixom.net>
 <20060413022809.GD24769@pb15.lixom.net>
 <20060413025233.GE24769@pb15.lixom.net>
 <20060413064027.GH10412@granada.merseine.nu>
 <1144925149.4935.14.camel@localhost.localdomain>
 <20060413160712.GG24769@pb15.lixom.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:07:12AM -0500, Olof Johansson wrote:

> Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> OF doesn't give the Airport device a logical name. It's probably easier
> to implement than walking PCI, but we'd need to maintain a table. My
> vote is for PCI walking, I'll give that a shot over the weekend.

Cool! bonus points if you do it in drivers/pci and we can steal it
easily for Calgary on x8-64 :-)

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

