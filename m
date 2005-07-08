Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVGHWbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVGHWbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVGHW3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:29:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31203 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262925AbVGHW1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:27:35 -0400
Subject: Re: 2.6.12.2 -- time passes faster; related to the
	acpi_register_gsi() call
From: Lee Revell <rlrevell@joe-job.com>
To: Phil Oester <kernel@linuxace.com>
Cc: Alexander Nyberg <alexn@telia.com>, Rudo Thomas <rudo@matfyz.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050708220309.GA16413@linuxace.com>
References: <20050708211203.GC382@ss1000.ms.mff.cuni.cz>
	 <1120857908.25294.33.camel@localhost.localdomain>
	 <20050708220309.GA16413@linuxace.com>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 18:27:33 -0400
Message-Id: <1120861653.6488.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 15:03 -0700, Phil Oester wrote:
> On Fri, Jul 08, 2005 at 11:25:08PM +0200, Alexander Nyberg wrote:
> > fre 2005-07-08 klockan 23:12 +0200 skrev Rudo Thomas:
> > > Hello, guys.
> > > 
> > > Time started to pass faster with 2.6.12.2 (actually, it was 2.6.12-ck3
> > > which is based on it). I have isolated the cause of the problem:
> > 
> > I bet you this fixes it (already in mainline)
> > 
> > If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
> 
> FYI, this did fix the time-passing-faster problem for me on a poweredge 750
> a few days ago.  I'd suggest this fix should go to -stable.

I think it's already queued for -stable.

Lee

