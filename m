Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVDAJc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVDAJc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVDAJc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:32:56 -0500
Received: from fmr17.intel.com ([134.134.136.16]:22173 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262669AbVDAJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:32:34 -0500
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ACPI] 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Fri, 1 Apr 2005 17:31:16 +0800
User-Agent: KMail/1.6.1
Cc: acpi-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
References: <200503291156.19112.rjw@sisk.pl> <200503301205.40555.rjw@sisk.pl> <200503311044.58673.rjw@sisk.pl>
In-Reply-To: <200503311044.58673.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200504011731.16467.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 31 March 2005 16:44, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday, 30 of March 2005 12:05, Rafael J. Wysocki wrote:
> > On Wednesday, 30 of March 2005 07:53, Yu, Luming wrote:
> > > On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
> > > > Hi,
> > > >
> > > > There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI
> > > > battery driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the
> > > > battery monitor that I use (the kpowersave applet from SUSE 9.2) is
> > > > no longer able to report the battery status (ie how much % it is
> > > > loaded).  It can only check if the AC power is connected (if it is
> > > > connected, kpowersave behaves as though there was no battery in the
> > > > box, and if it is not connected, kpowersave always shows that the
> > > > battery is 1% loaded).
> > > >
> > > > Also, there are big latencies on loading and accessing the battery
> > > > module, but the module loads successfully and there's nothing
> > > > suspicious in dmesg.
> > > >
> > > > Please let me know if you need any additional information.
> > > >
> > > > Greets,
> > > > Rafael
> > >
> > > Could you just revert ec-mode patch, then retest?
> >
> > Could you please point me to it?
>
> I assume you mean the "Enable EC Burst Mode" patch at:
>
> http://linux-acpi.bkbits.net:8080/to-akpm/cset%401.2181.17.12?nav=index.htm
>l|ChangeSet@-2w
>
> Anyway, reverting this patch helps. :-)

Could you let me see Dmesg and  DSDT?

TIA
