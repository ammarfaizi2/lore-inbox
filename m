Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbULOOrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbULOOrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbULOOrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:47:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10439 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262360AbULOOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:46:59 -0500
Date: Tue, 14 Dec 2004 19:18:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume from PCI devices
Message-ID: <20041214181819.GB5267@openzaurus.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com> <20041214110648.GA2291@elf.ucw.cz> <1103039717.10857.53.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103039717.10857.53.camel@athena.fprintf.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This isn't a nice regression.
> > 
> > So what was the last kernel where it worked?
> 
> For me, 2.6.9-rc4.  I've tried every -rc and -mm since, and it cannot
> resume.  (I get no video on resume, even with 2.6.9-rc4, until X

Okay, perhaps you are lucky, diff between 2.6.9-rc4 and 2.6.9
should be fairly small. Could you find which changeset is responsible?
bkcvs should be really usefull here.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

