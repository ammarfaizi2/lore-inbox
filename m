Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVBPTke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVBPTke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBPTkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:40:33 -0500
Received: from poup.poupinou.org ([195.101.94.96]:48165 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S261762AbVBPTkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:40:16 -0500
Date: Wed, 16 Feb 2005 20:40:17 +0100
To: Stelian Pop <stelian@popies.net>, Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050216194017.GQ1145@poupinou.org>
References: <20050210161809.GK3493@crusoe.alcove-fr> <1108481448.2097.71.camel@d845pe> <20050215153912.GA3523@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215153912.GA3523@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6+20040907i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > platform specific wart is the only way to go.  But
> > it would be best if we can make the exotic Sony/SNC
> > look more generic to the user so that the user
> > (and the distro supporting them) don't need to learn
> > special things to handle this system.
> 
> I agree, but unfortunately I don't think it's possible to handle
> them in a generic way. However, my understanding of the ACPI layer
> is limited, so I very well be wrong.
> 
> I attached two DSDT in bugzilla, I have a few more if you want them.
> 

I will (re)work some part of the acpi_video stuff in order to make it
more generic (its design is to separate a kind of 'video bus', then
'video devices' can attach.  For now, its support only one kind of device,
the acpi one.  See acpi_viedo.c).  The original goal was to atleast
attach others acpi specific drivers (the toshiba at that time).

Problem though is my time which unfortunately is missing currently
(professional stuff, other free projects and even real life) and
I must admit I don't intend to work on acpi_video right now.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
