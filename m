Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVBPQLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVBPQLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVBPQKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:10:38 -0500
Received: from mail1.upco.es ([130.206.70.227]:27091 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262062AbVBPQKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:10:05 -0500
Date: Wed, 16 Feb 2005 17:10:00 +0100
From: Romano Giannetti <romanol@upco.es>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Norbert Preining <preining@logic.at>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050216161000.GA3381@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	Norbert Preining <preining@logic.at>, Pavel Machek <pavel@suse.cz>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
	rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050216093454.GC22816@pern.dea.icai.upco.es> <42135EAE.8030407@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <42135EAE.8030407@gmx.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 03:54:38PM +0100, Carl-Daniel Hailfinger wrote:
> Romano Giannetti schrieb:
> > 
> > I tried with my Sony Vaio FX701. No luck. It goes S3 ok, but it will never
> > come back (blank screen, HDD led fixed on). 
> > 
> > I am wishing to help, imply tell me what I have to do.
> 
> Please tell us about your graphics chipset, your .config, your
> dmesg and the modules loaded. Then we my be able to help.

Oops, sorry, I should have added the info before. My apologies. 

Here will find all the info (if you need more, tell me). Note that I tried
with and without ndiswrapper driver loaded, and I have the same hang on
resume (blank screen, HDD light fixed on, and no answer to wireless pings). 

One more note: the ndiswrapper *did* survive OK to a disk suspend cycle. 

I am running an up-to-date Mandrake 10.0 distribution, with 
a kernel 2.6.11-rc1 (Linus tree), on a Sony Vaio PGC-FX701 which is almost
working perfectly. 

* Patch applied: 
  - a little patch for ALPS pad detection.
  http://www.dea.icai.upco.es/romano/linux/alps-detection-2611rc1.txt

* .config:
  http://www.dea.icai.upco.es/romano/linux/config-2.6.11rc1.txt

* lsmod after boot: 
  http://www.dea.icai.upco.es/romano/linux/lsmod.txt

* lspci -vv
  http://www.dea.icai.upco.es/romano/linux/lspci.txt

* dmesg
  http://www.dea.icai.upco.es/romano/linux/dmesg.txt

* /proc/acpi/dsdt
  http://www.dea.icai.upco.es/romano/linux/mydsdt.bin

More data on http://perso.wanadoo.es/r_mano/vaio/vaio.html

Thanks again,
             Romano


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
