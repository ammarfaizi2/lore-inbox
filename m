Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVCDUp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVCDUp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVCDUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:43:44 -0500
Received: from bender.bawue.de ([193.7.176.20]:6372 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263084AbVCDUdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:33:37 -0500
Date: Fri, 4 Mar 2005 21:33:30 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [SATA] libata-dev queue updated
Message-ID: <20050304203330.GA14557@sommrey.de>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>
References: <3Ds62-5AS-3@gated-at.bofh.it> <200503022034.j22KYppm010967@bear.sommrey.de> <422641AF.8070309@pobox.com> <20050303193229.GA10265@sommrey.de> <4227DF76.3030401@pobox.com> <20050304063717.GA12203@sommrey.de> <422809D6.5090909@pobox.com> <20050304174956.GA10971@sommrey.de> <4228A3D4.8050906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228A3D4.8050906@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:07:16PM -0500, Jeff Garzik wrote:
> Joerg Sommrey wrote:
> >On Fri, Mar 04, 2005 at 02:10:14AM -0500, Jeff Garzik wrote:
> >
> >>Joerg Sommrey wrote:
> >>
> >>>On Thu, Mar 03, 2005 at 11:09:26PM -0500, Jeff Garzik wrote:
> >>>
> >>>
> >>>>Joerg Sommrey wrote:
> >>>>
> >>>>
> >>>>>On Wed, Mar 02, 2005 at 05:43:59PM -0500, Jeff Garzik wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>>Joerg Sommrey wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>>Jeff Garzik wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>Patch:
> >>>>>>>>http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc5-bk4-libata-dev1.patch.bz2
> >>>>>>>
> >>>>>>>
> >>>>>>>Still not usable here.  The same errors as before when backing up:
> >>>>>>
> >>>>>>Please try 2.6.11 without any patches.
> >>>>>
> >>>>>Plain 2.6.11 doesn't work either.  All of 2.6.10-ac11, 2.6.11-rc5,
> >>>>>2.6.11-rc5 + 2.6.11-rc5-bk4-libata-dev1.patch and 2.6.11 fail with the
> >>>>>same symptoms. 
> >>>>>
> >>>>>Reverting to stable 2.6.10-ac8 :-)
> >>>>
> >>>>Does reverting the attached patch in 2.6.11 (apply with patch -R) fix 
> >>>>things?
> >>>>
> >>>
> >>>
> >>>Still the same with this patch reverted.
> >>
> >>Does reverting the attached patch in 2.6.11 fix things?  (apply with 
> >>patch -R)
> >>
> >>This patch reverts the entire libata back to 2.6.10.
> >>
> >
> >I'm confused.  Still the same with everything reverted.  What shall I do
> >now?
> 
> Well, first, thanks for your patience in narrowing this down.
> 
> This means we have eliminated libata as a problem source, but we still 
> have the rest of the kernel go to through :)
> 
> Try disabling ACPI with 'acpi=off' or 'pci=biosirq' to see if that fixes 
> things.
> 
I tried both settings with plain 2.6.11. Almost the same results, in my
impression apci=off causes the failure to appear even faster.

-jo

-- 
-rw-r--r--  1 jo users 63 2005-03-04 20:54 /home/jo/.signature
