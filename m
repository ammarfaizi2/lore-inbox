Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVDAJRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVDAJRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVDAJRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:17:19 -0500
Received: from mail1.upco.es ([130.206.70.227]:61873 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261605AbVDAJRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:17:12 -0500
Date: Fri, 1 Apr 2005 11:17:08 +0200
From: Romano Giannetti <romanol@upco.es>
To: Maximilian Engelhardt <maxi@daemonizer.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050401091708.GA31787@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Maximilian Engelhardt <maxi@daemonizer.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>
References: <3xVNA-Qn-43@gated-at.bofh.it> <1111089912.9802.26.camel@mobile> <20050318145028.GA22887@pern.dea.icai.upco.es> <1112298873.10156.18.camel@mobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1112298873.10156.18.camel@mobile>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 09:54:33PM +0200, Maximilian Engelhardt wrote:
> On Fri, 2005-03-18 at 15:50 +0100, Romano Giannetti wrote:
> > 
> > It happens exactly the same on my laptop, sony vaio whose configuration is 
> > 
> > http://www.dea.icai.upco.es/romano/linux/vaio-conf/laptop-config.html
> 
> I was able to get some logs using CONFIG_LP_CONSOLE (the first time I
> ever saw "Back to C!"):
> 
> Back to C!
> PM: Finishing up.
> ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level,low) -> IRQ 10
> MCE: The hardware reports a non fatal, correctable incident occurred on
> CPU 0.
> Bank 1: e200000000000001
> hda: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_out_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: unknown
> 
> keeps on always repeating last three messages until I reboot
> 
> Full log:
> http://home.daemonizer.de/resume.png
> 
> kernel version is 2.6.11
> config: http://home.daemonizer.de/config-2.6.11-S3test
> dmesg from booting: http://home.daemonizer.de/dmesg-2.6.11-S3test
> lspci: http://home.daemonizer.de/lspci
> Gentoo Base System version 1.6.10
> 
> Hardware:
> Acer Travelmate 661lci (centrino)
> Intel(R) Pentium(R) M processor 1400MHz

I tried with serial console. The only thing I get is: 

Stopping tasks:
================================================================================|

and nothing more. Well, this was done with the double console, so that I
will try again as soon as I have a bit of time with just the serial console
on. 

But the "external" behaviour for me is like your: it stops, then at restart
the HDD led stays on and nothing happen. 


Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
