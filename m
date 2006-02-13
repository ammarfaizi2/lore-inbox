Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWBMLFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWBMLFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBMLFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:05:46 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:15780 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751114AbWBMLFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:05:45 -0500
Date: Mon, 13 Feb 2006 13:05:42 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16, sk98lin out of date
Message-ID: <20060213110542.GZ3927@mea-ext.zmailer.org>
References: <200602131058.03419.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602131058.03419.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:58:03AM +0000, Alistair John Strachan wrote:
> From:	Alistair John Strachan <s0348365@sms.ed.ac.uk>
> To:	netdev@vger.kernel.org
> Subject: 2.6.16, sk98lin out of date
> Date:	Mon, 13 Feb 2006 10:58:03 +0000
> Cc:	linux-kernel@vger.kernel.org
> 
> Hi,
> 
> As I'm sure the drivers/net maintainers are well aware, SysKonnect constantly 
> update their sk98lin/sky2 driver without bothering to sync their changes with 
> the official linux kernel.

My understanding is, that  skge  driver has superceded the  sk98lin  in
most uses.

There could, of course, be a change to insert vendor driver _as_is_ into
baseline kernel with its own name.


> I quickly downloaded driver version 8.31 from http://www.skd.de/ today and 
> used the install script to generate a diff against 2.6.16-rc3. Even after 
> fixing up some DOS EOLs in the package, the diff was still well over 1.5MBs. 
> This is an enormous number of changes.
> 
> The reason I'm posting is that my DFI LanParty-UT SLI-D works with this 
> version of the driver, but not the version 2.6.16-rc3.
> 
> [alistair] 10:55 [~] dmesg | grep sk98lin
> sk98lin: Could not read VPD data.
> sk98lin: probe of 0000:01:0a.0 failed with error -5
> 
> I wonder if it's worth just identifying the "quick fix" (I've seen
> workarounds for corrupt VPDs like mine) or whether a general merge
> up would be beneficial..

See if  'skge'  driver would work instead of  'sk98lin'  ?

> If nobody's maintaining this driver I wouldn't mind helping out.
> 
> -- 
> Cheers,
> Alistair.

  /Matti Aarnio
