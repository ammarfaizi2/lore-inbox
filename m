Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWEATro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWEATro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWEATro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:47:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33473 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932207AbWEATrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:47:43 -0400
Subject: RE: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch
	brokeuserspace apps
From: john stultz <johnstul@us.ibm.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DB5E@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB652DB5E@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 12:47:39 -0700
Message-Id: <1146512859.18531.0.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 15:40 -0400, Brown, Len wrote:
>  >> [root@antares ~]# grep clocksource dmesg-2.6.17-rc*
> >> dmesg-2.6.17-rc1-mm1:Time: tsc clocksource has been installed.
> >> dmesg-2.6.17-rc1-mm1:Time: acpi_pm clocksource has been installed.
> >> dmesg-2.6.17-rc1-mm2:Time: tsc clocksource has been installed.
> >> dmesg-2.6.17-rc1-mm2:Time: acpi_pm clocksource has been installed.
> >> dmesg-2.6.17-rc1-mm3:Time: tsc clocksource has been installed.
> >> dmesg-2.6.17-rc1-mm3:Time: pit clocksource has been installed.
> >> dmesg-2.6.17-rc2-mm1:Time: tsc clocksource has been installed.
> >> dmesg-2.6.17-rc2-mm1:Time: pit clocksource has been installed.
> >
> >Hmmm. I'm not sure why the ACPI PM timer isn't showing up. Your .config
> >looks good, but I don't see the ACPI PM timer io-port being detected as
> >I expect.
> >
> >Len, has there been any changes to that ACPI code?
> 
> Not that I'm aware of.
> Is this issue in -mm only, or does this issue show up in Linus' tree?

>From the report it seems to be -mm only.

thanks
-john


