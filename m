Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWHLAHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWHLAHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 20:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWHLAHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 20:07:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964789AbWHLAHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 20:07:15 -0400
Date: Fri, 11 Aug 2006 20:06:36 -0400
From: Dave Jones <davej@redhat.com>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060812000636.GB28540@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Koeller <thomas@koeller.dyndns.org>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120149.23380.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
 > On Friday 11 August 2006 22:56, Dave Jones wrote:
 > > On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
 > >  > This is a driver for the on-chip watchdog device found on some
 > >  > MIPS RM9000 processors.
 > >  >
 > >  > Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
 > >
 > > Mostly same nit-picking comments as your other driver..
 > 
 > Which one?

The image capture driver.

 > >  > +#include <linux/config.h>
 > >
 > > not needed.
 > 
 > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

kbuild automatically includes it for you in the last few kernels.


 > > As in the previous driver, are these barriers strong enough?
 > > Or do they need explicit reads of the written addresses to flush the write?
 > 
 > I think they are. Remember, the entire device is integrated in the
 > processor. No external buses involved.

Ok.

		Dave

-- 
http://www.codemonkey.org.uk
