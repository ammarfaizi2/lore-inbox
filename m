Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVBPCpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVBPCpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 21:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVBPCpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 21:45:25 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:964 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261973AbVBPCpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 21:45:18 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Alistair John Strachan <alistair@devzero.co.uk>,
       Lorenzo Colitti <lorenzo@colitti.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
In-Reply-To: <20050216015418.GC13753@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <1108500194.12031.21.camel@elrond.flymine.org>
	 <42126506.8020407@colitti.com> <200502160141.11633.alistair@devzero.co.uk>
	 <20050216015418.GC13753@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1108522024.3712.44.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 16 Feb 2005 13:47:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-02-16 at 12:54, Pavel Machek wrote:
> > Also, is USB suspend/resume supposed to work? My brief trials involved 
> > modprobing the USB HCD modules, which still allowed me to suspend/resume, but 
> > my USB mouse was non-functional on resume.
> 
> Yes, it seems to work quite okay. You may need to unplug/replug
> devices after resume, but it should be basically ok.

We still have plenty of people for whom the best option is to build as
modules, unload prior to suspending and reload afterwards. It seems to
depend on what type your controller is: I do this for uhci_hcd and get
fully functional usb post resume (-rc4).

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

