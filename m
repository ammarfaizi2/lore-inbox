Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVGZVgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVGZVgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGZVeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:34:13 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:23722 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262139AbVGZVcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:32:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
Date: Tue, 26 Jul 2005 23:37:42 +0200
User-Agent: KMail/1.8.1
Cc: Peter Buckingham <peter@pantasys.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200507261247.05684.rjw@sisk.pl> <200507262302.37488.rjw@sisk.pl> <42E6A6E7.5000402@pantasys.com>
In-Reply-To: <42E6A6E7.5000402@pantasys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507262337.43208.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 of July 2005 23:11, Peter Buckingham wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday, 26 of July 2005 14:25, Carl-Daniel Hailfinger wrote:
> >>The current in-kernel sk98lin driver is years behind the version
> >>downloadable from Syskonnect. Maybe it would make sense to update
> >>it first before applying any new patches.
> >>http://www.syskonnect.com/support/driver/d0102_driver.html
> > 
> > 
> > You are right, but I don't know who should do this.  I have only submitted
> > the patch to eliminate a problem with the current kernel.
> 
> have a look at the skge driver, this is a cleaned up version of the 
> sk98lin. Although it doesn't support all of the devices, ie ones based 
> on the Yukon 2.

Thanks for the hint, I will.  From the first look it's missing the
free_irq()/request_irq() on suspend/resume however.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
