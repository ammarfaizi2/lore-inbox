Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVBVOdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVBVOdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVBVOdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:33:24 -0500
Received: from hell.org.pl ([62.233.239.4]:53516 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262309AbVBVOdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:33:23 -0500
Date: Tue, 22 Feb 2005 15:33:22 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Kjartan Maraas <kmaraas@broadpark.no>,
       Lorenzo Colitti <lorenzo@colitti.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Message-ID: <20050222143322.GA538@hell.org.pl>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Kjartan Maraas <kmaraas@broadpark.no>,
	Lorenzo Colitti <lorenzo@colitti.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
	rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <200502151742.55362.s0348365@sms.ed.ac.uk> <1108563926.4986.3.camel@localhost.localdomain> <200502182049.11088.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200502182049.11088.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Alistair John Strachan:
> I discovered that either the i2c_core.ko or i2c_i801.ko modules cause the hang 
> on resume! If you stop the entire i2c subsystem from being loaded by hotplug 
> (note this is the BUS driver, not the sensors driver!), then resume works 
> perfectly! Presumably there's a bug in the resuming of this module.

Might it be another instance of the LPC chip config space messed up on resume?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
