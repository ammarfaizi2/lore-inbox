Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbSLSGjj>; Thu, 19 Dec 2002 01:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbSLSGjj>; Thu, 19 Dec 2002 01:39:39 -0500
Received: from willow.seitz.com ([146.145.147.180]:16 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S267548AbSLSGjj>;
	Thu, 19 Dec 2002 01:39:39 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Thu, 19 Dec 2002 01:47:12 -0500
To: "D.A.M. Revok" <marvin@synapse.net>
Cc: linux-kernel@vger.kernel.org, rossb@google.com
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133  Promise ctrlr, or...
Message-ID: <20021219064712.GA29538@willow.seitz.com>
References: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org> <200212181635.58164.marvin@synapse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212181635.58164.marvin@synapse.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 04:35:58PM -0500, D.A.M. Revok wrote:
> I figured out what it is, more...
> hdparm -X12 ( to set PIO instead of UDMA ) /does not/ fix it, so I dug 
> into BIOS and re-enabled the bios for that controller...

Ah, I can verify this has fixed the lockups for me too.  I previously
had the BIOS disabled cause it takes so long to boot, but recently
reenabled it.  smartctl can hapily operate on all drives now.

> Does my having the "bios" for that controller turned off create the 
> problem? ( I don't boot from those drives, so didn't see any reason to 
> have it...  )

I do now boot from my Promise controlled drives, and yes, I need the
BIOS.

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.
