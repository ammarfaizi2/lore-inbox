Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUCVBEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 20:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUCVBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 20:04:08 -0500
Received: from mta04-svc.ntlworld.com ([62.253.162.44]:19951 "EHLO
	mta04-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261602AbUCVBED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 20:04:03 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Mon, 22 Mar 2004 01:04:10 +0000
User-Agent: KMail/1.6.1
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Len Brown <len.brown@intel.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <200403210333.i2L3XQiw024997@eeyore.valparaiso.cl> <200403212032.28474.richard@redline.org.uk> <200403220133.21659.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200403220133.21659.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403220104.10619.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 March 2004 23:33, Denis Vlasenko wrote:
> But it must be SOMETHING, right?

I haven't been completely idle :)


> Kernel compile is too broad. Can you try to narrow it down?
> Does burnCPU trigger it? Several burnCPUs?
> dd if=/dev/hda of=/dev/null?
> dd if=/dev/zero of=file bs=1M count=128?
> network flood? (/me uses netcat and UDP)
> Combination of above?

As I suggested in the original post, the problem can be triggered simply by 
executing ./configure - the kernel corrupts when gcc does its thing. I can 
boot into KDE, run Enemy Territory, execute a Java compile, and so on. But 
the thing absolutely and most definitely able to upset the cart is to execute 
gcc.

Oh, I've even recompiled libgcc etc using a variety of optimisation flags 
(Gentoo is my distro), from the sooper-over-the-top P4 flags down to simple 
-O2 -march=pentium3. With no effect.


> Then, you will be able to call for testing.

Because I have exhausted my own meagre talents in the search for the cause (eg 
swapping hardware, altering config parameters, using different hard drives, 
etc) I felt the time was right to 'call in the experts'.


> You can post your kernel version and .config

I've done that, too, oddly enough. The config, cpuinfo, pci, the works. It's 
all there in the original thread.


> and ask folks who has identical hardware to try
> to duplicate.

The nearest I've got is someone who has the same mobo but with different CPUs, 
no AGP graphics card and no SATA.

Like I said, as a software engineer of some 20 years (heavens! I had my first 
game published when I was 14, lovingly handcrafted in 65c102 assember), I am 
aware of the steps required to pinpoint an issue. The penultimate one - the 
last, of course, is to give up - is to enlist the help of others who know 
more. That is what I've done.

R
