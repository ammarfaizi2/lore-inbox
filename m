Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSIZP2Q>; Thu, 26 Sep 2002 11:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSIZP2Q>; Thu, 26 Sep 2002 11:28:16 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:58800 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261390AbSIZP2P>;
	Thu, 26 Sep 2002 11:28:15 -0400
Date: Thu, 26 Sep 2002 16:34:10 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 20020912161258.A9056@informatics.muni.cz, linux-kernel@vger.kernel.org,
       Mark Hahn <hahn@physics.mcmaster.ca>, kernel@street-vision.com,
       Petr Konecny <pekon@informatics.muni.cz>,
       "Bruno A. Crespo" <bruno@conectatv.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
Message-ID: <20020926153410.GA4381@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	20020912161258.A9056@informatics.muni.cz,
	linux-kernel@vger.kernel.org, Mark Hahn <hahn@physics.mcmaster.ca>,
	kernel@street-vision.com, Petr Konecny <pekon@informatics.muni.cz>,
	"Bruno A. Crespo" <bruno@conectatv.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <20020925132422.GC14381@fi.muni.cz> <1033052890.1269.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033052890.1269.28.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 04:08:10PM +0100, Alan Cox wrote:
 > Looks like the obvious fix is to simply disable the APIC on all such
 > systems

Converting a *lot* of MP systems to UP due to an errata
that only occurs with no PS/2 mouse seems a bit extreme.
Can we safely probe the PS2 port to see if its empty or not
and do a runtime APIC/SMP disable really early in the boot ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
