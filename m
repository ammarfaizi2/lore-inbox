Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTLSKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 05:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTLSKgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 05:36:16 -0500
Received: from legolas.restena.lu ([158.64.1.34]:26767 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S262353AbTLSKgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 05:36:14 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, george@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312191538.34551.ross@datscreative.com.au>
References: <200312180414.17925.ross@datscreative.com.au>
	 <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
	 <1071757363.18749.42.camel@athlonxp.bradney.info>
	 <200312191538.34551.ross@datscreative.com.au>
Content-Type: text/plain
Message-Id: <1071830168.5624.2.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 11:36:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 06:38, Ross Dickson wrote:
> On Friday 19 December 2003 00:22, Craig Bradney wrote:
> > Just as an FYI, still going strong here with the old api and ioapic
> > patches. 5d 20h now.
> > 
> > When the official 2.6.0 comes to Gentoo Linux I can try that with
> > whatever patches people are finding stable for these nforce fixes.
> > 
> > Anyone had any luck in talking to ASUS re a BIOS update?
> > 
> > Craig
> > 
> 
> I have not talked to ASUS. I note from peoples postings that with the
> latest award bios we may need no apic patches (C1 disconnect auto),
> just an ioapic one to work round a buggy bios. I don't think you can run
> nmi_watchdog=1 with the old io-apic (not of my doing) patch.
> 
> I have pheonix bios MOBOS from albatron and epox so award bios doesn't help me.
> No disconnect options available in setup.
> My apic ack delay patch lets the bios have its disconnect on and keep the cpu a
> few degrees cooler besides whatever else it and the nforce2 chipset might want
> to control it for.
> 
> I have been advised my query wrt my apic ack delay patch is progressing
> with AMD but I have nothing technical to report on it.
> 
> I have made and am trialling, but have not yet posted a kernel arg controlled
> version combining my v1 and v2 apic ack delay patches. This would be better
> than what I have released in the past because people can fix bioses as the
> fixes become available and use timer ack delay in the mean time.
> Of course there is still athcool and the earlier disconnect patch to force 
> things if desired.
> 
> Regards
> Ross.

Ok Ross. Well, Gentoo's 2.6 is out now so whenever you want me to test
your new patch I can try it. Ive been looking back through the list for
the updated patches but things seemed to have changed here and there
even for the v2 patches so I think I'll wait for the next round of
patchesas things seem a little confusing.

2.6test11 is still running happily.. 6d15h now.

Craig

