Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUIORRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUIORRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUIORQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:16:35 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:2534 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266878AbUIORO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:14:28 -0400
Subject: Re: open source realtek driver for 8180
From: David Hollis <dhollis@davehollis.com>
Reply-To: dhollis@davehollis.com
To: tuxrocks@cox.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040915161113.BVQI25194.lakermmtao01.cox.net@smtp.east.cox.net>
References: <20040915161113.BVQI25194.lakermmtao01.cox.net@smtp.east.cox.net>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 13:14:33 -0400
Message-Id: <1095268473.6499.4.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 12:11 -0400, tuxrocks@cox.net wrote:
> Hello all.  I posted to the list in July concerning the possible importance of the infamous 8180 chipset specifications in developing an open-source (and more complete) driver.  Jeff Garzik replied that a driver was forthcoming by late August.  I was just curious as to where I should be keeping an eye out for the driver (there are currently two projects at sourceforge developing drivers for this chipset, was Jeff refering to one of these?) and if development was getting close to completion.  Please cc me any replies.
> Thanks for your time, and thanks to all of the developers!
> --Wayne
> 

I'm quite interested in this driver as well.  At the moment I'm stuck
using the ndiswrapper to make the card work but it's not how I would
like to do things long term.  I looked at the rtl8180+sa2400 driver at
sourceforge and it seems to be the most promising but the code is in
pretty bad shape.  It won't compile against a recent kernel using gcc
3.4 without a load of warnings and errors due to the coding style.  I
also found a project (forget where exactly) that is focused on making
the existing Realtek drivers work under 2.6 kernels.  The Realtek
drivers do the typical link-to-precompiled-object bit and are designed
for 2.4.  I haven't played with them myself so I don't know if they work
or not.  I would really prefer a standard, well-written fully open
driver (wouldn't we all!) that at worst requires a firmware binary to be
loaded.  The prism54 and ipw2x00 drivers come to mind...

-- 
David Hollis <dhollis@davehollis.com>

