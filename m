Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263677AbUCYWmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUCYWlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:41:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:61319 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263677AbUCYWjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:39:16 -0500
Subject: Re: RadeonFB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stewart Smith <stewart@flamingspork.com>
Cc: Oystein Haare <lkml-account@mazdaracing.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1080187819.2763.1.camel@kennedy>
References: <1079366460.853.3.camel@dawn>  <1080187819.2763.1.camel@kennedy>
Content-Type: text/plain
Message-Id: <1080254335.1195.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 09:38:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is what it outputs:
> > 
> > radeonfb: Found Intel x86 BIOS ROM Image
> > radeonfb: Retreived PLL infos from BIOS
> > radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz,
> > System=220.00 MHz
> > Non-DDC laptop panel detected
> > radeonfb: Monitor 1 type LCD found
> > radeonfb: Monitor 2 type no found
> > radeonfb: panel ID string: Samsung LTN150P1-L02    
> > radeonfb: detected LVDS panel size from BIOS: 1400x1050
> > radeondb: BIOS provided dividers will be used
> > radeonfb: Assuming panel size 1400x1050
> > radeonfb: Power Management enabled for Mobility chipsets
> > radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> > 
> > Could the flickering have something to do with the fact that the lcd
> > panel on my laptop can only do 1280x800 resolution? Or doesn't the
> > 1400x1050 have anything to do with resolution at all?
> >

That's weird. Yet another case of BIOS lying about the panel
size. Can you try enabling DDC I2C probing ?

Ben.


