Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUCUXsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCUXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:48:51 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:37132 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261497AbUCUXss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:48:48 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Richard Browning <richard@redline.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Mon, 22 Mar 2004 01:33:21 +0200
User-Agent: KMail/1.5.4
Cc: Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <200403210333.i2L3XQiw024997@eeyore.valparaiso.cl> <200403212032.28474.richard@redline.org.uk>
In-Reply-To: <200403212032.28474.richard@redline.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403220133.21659.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 March 2004 22:32, Richard Browning wrote:
> On Sunday 21 March 2004 03:33, Horst von Brand wrote:
> > In my experience, when Linux crashes, Windows works fine it is flaky
> > hardware. Has variously been overclocking, bad fans (CPU overheating),
> > bad RAM. You have to rule all that out first. Might need a BIOS update...
>
> Done all that. Changed motherboards, changed CPUs, changed RAM. Haven't
> changed graphics card, though. I don't know where else to get a
> Radeon9800Pro from on loan! I don't overclock either. I'm confident it's
> not the hardware.

But it must be SOMETHING, right?

Kernel compile is too broad. Can you try to narrow it down?
Does burnCPU trigger it? Several burnCPUs?
dd if=/dev/hda of=/dev/null?
dd if=/dev/zero of=file bs=1M count=128?
network flood? (/me uses netcat and UDP)
Combination of above?

Then, you will be able to call for testing.
You can post your kernel version and .config
and ask folks who has identical hardware to try
to duplicate.
--
vda

