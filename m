Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbSLKPTW>; Wed, 11 Dec 2002 10:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSLKPTW>; Wed, 11 Dec 2002 10:19:22 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:45506
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267183AbSLKPTV>; Wed, 11 Dec 2002 10:19:21 -0500
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Andrew McGregor <andrew@indranet.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20021211101438.GC29390@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com>
	<1039481341.12046.21.camel@irongate.swansea.linux.org.uk>
	<20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
	<23440000.1039553448@localhost.localdomain> 
	<20021211101438.GC29390@poup.poupinou.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 16:00:14 +0000
Message-Id: <1039622414.17702.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 10:14, Ducrot Bruno wrote:
> No.  You are wrong.  I need to suspend allmost all the drivers, and the
> video chipset is not an execption (or go to a console before suspending,
> in fact).
> You still need to bug NVIDIA in order to have proper pm support
> in their driver.

To an extent. However you can also switch back to text mode on suspend
to disk, then resume back into text mode and effectively switch back
into X11

