Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWDMGmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWDMGmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDMGmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:42:20 -0400
Received: from mtaout4.012.net.il ([84.95.2.10]:40629 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S932420AbWDMGmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:42:20 -0400
Date: Thu, 13 Apr 2006 09:40:27 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
 V2
In-reply-to: <20060413025233.GE24769@pb15.lixom.net>
To: Olof Johansson <olof@lixom.net>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Message-id: <20060413064027.GH10412@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060413020559.GC24769@pb15.lixom.net>
 <20060413022809.GD24769@pb15.lixom.net> <20060413025233.GE24769@pb15.lixom.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:

> iommu=off can still be used for those who don't want to deal with the
> overhead (and don't need it for any devices).

I've been pondering walking the PCI bus before deciding to enable an
IOMMU and checking each device's DMA mask. Is this something that you
considered and rejected, or just something no one got around to doing?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

