Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSKUNFR>; Thu, 21 Nov 2002 08:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbSKUNFR>; Thu, 21 Nov 2002 08:05:17 -0500
Received: from poup.poupinou.org ([195.101.94.96]:19982 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S266633AbSKUNFQ>; Thu, 21 Nov 2002 08:05:16 -0500
Date: Thu, 21 Nov 2002 14:11:29 +0100
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Felix Seeger <seeger@sitewaerts.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021121131129.GD707@poup.poupinou.org>
References: <1037831055.3241.97.camel@irongate.swansea.linux.org.uk> <EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com> <25526.1037828842@passion.cambridge.redhat.com> <25766.1037829570@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25766.1037829570@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 09:59:30PM +0000, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  I guess sonypi could take the ACPI global lock ?
> 
> I assume that's not a serious suggestion. Perhaps it could release the 
> region while it's not _actually_ using it, and the ACPI code could be fixed 
> to not touch regions which it doesn't own.
> 
> Or we write proper PM code for sonypi and make it not possible to use both 
> sonypi and ACPI at once.

It could be a solution, especially if you have a proper APM, but
you have also to implement in sonypi at least a replacement for the
idle loop in order to get power state saving of the processor, and
also have more battery saving.  Of course, this is the first feature
I think about the new acpi code.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
