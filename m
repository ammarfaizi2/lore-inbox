Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGDVDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGDVDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVGDVDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:03:14 -0400
Received: from iron.pdx.net ([207.149.241.18]:49831 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S261691AbVGDVC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:02:59 -0400
Subject: Re: ASUS K8N-DL Beta BIOS
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Alexander Nyberg <alexn@telia.com>
Cc: Andi Kleen <ak@muc.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Hodle, Brian" <BHodle@harcroschem.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'ipsoa@posiden.hopto.org'" <ipsoa@posiden.hopto.org>
In-Reply-To: <1120507617.5304.1.camel@home-lap>
References: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1>
	 <1120246927.2764.26.camel@home-lap>
	 <200507021843.45450.s0348365@sms.ed.ac.uk>  <20050702194455.GA80118@muc.de>
	 <1120365125.4107.4.camel@home-lap>
	 <1120376236.1175.1.camel@localhost.localdomain>
	 <1120507617.5304.1.camel@home-lap>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 14:02:53 -0700
Message-Id: <1120510973.5304.6.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even more fun today with the ASUS release 1004 of the BIOS.   Looks like
you CANNOT disable the Nvidia SATA controller without causing the system
to lock.  I can't seem to work around this new issue with the system
without backing my BIOS down to 1003.

With the Nvidia SATA controller enabled, 2.6.12.2 seems to go insane
attempting to talk with it(nv_raid seems to have trouble).  I am not
going to document this issue, as there are so many other issues that are
on-going with this board.

It's starting to look like this is a large and expensive exchanger of
electricity for heat at this point.

2.6.13-rc1 has some kind of issue with my board due to it's 6GB of RAM.
It stops when it discovers that there is no "IOMMU".  Since I don't see
anything obvious in the BIOS to activate, I can't boot 2.6.13 at all.

Sean

