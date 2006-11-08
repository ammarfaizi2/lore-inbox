Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754463AbWKHJEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbWKHJEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754462AbWKHJEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:04:24 -0500
Received: from antispam.upcomillas.es ([130.206.70.245]:5049 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1754463AbWKHJEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:04:22 -0500
Subject: Re: pcmcia: patch to fix pccard_store_cis
From: Romano Giannetti <romano.giannetti@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
       fabrice@bellet.info, linux-kernel@vger.kernel.org
In-Reply-To: <20061103160247.GB11160@dominikbrodowski.de>
References: <20061001122107.9260aa5d.zaitcev@redhat.com> 
	<20061002003138.GB16938@isilmar.linta.de> 
	<1159794094.8246.2.camel@localhost> 
	<20061103160247.GB11160@dominikbrodowski.de>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 10:04:19 +0100
Message-Id: <1162976659.15344.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-imss-version: 2.5
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:8 M:2 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 11:02 -0500, Dominik Brodowski wrote:
> Hi,
> 
> On Mon, Oct 02, 2006 at 03:01:34PM +0200, Romano Giannetti wrote:

> > 
> > https://launchpad.net/distros/ubuntu/+source/pcmciautils/+bug/52510
> > 
> > and here: 
> > 
> > http://lists.infradead.org/pipermail/linux-pcmcia/2006-August/003893.html
> > 
> > and my modem did work without IRQ problems after I got rid of .cis and
> > started (obsolete) cardmgr. Just as a data point more... 
> 
> Does it work again (after re-copying the cis file to /lib/firmware) when
> you use this patch?
> 

Will try... I have upgraded to ubuntu edgy yesterday, where I think some
thing changed (it's a 2.16.17-based kernel). I had no time to test it
more thoroughly, but the change is that now (standard edgy kernel): 
- only the first function is recognized
- if i start cardmgr, without the .cis, the two function are recognized
but now I *do* have the irq problem, and the modem is all-time-busy.

If tomorrow my little one sleeps a bit more, I will try to test your
patch. I hope I'll find how to apply it to that kernel, I do not want to
change it (for the first time my vaio suspend to ram and my  wifi works
without ndiswrapper!).

Romano 
 



-- 
Romano Giannetti <romano.giannetti@gmail.com>

