Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbUCXEBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUCXEBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:01:25 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:21427 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262997AbUCXEBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:01:24 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Wed, 24 Mar 2004 04:01:42 +0000
User-Agent: KMail/1.6.1
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       <linux-kernel@vger.kernel.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <Pine.LNX.4.44.0403220823020.2831-100000@poirot.grange>
In-Reply-To: <Pine.LNX.4.44.0403220823020.2831-100000@poirot.grange>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403240401.42322.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 07:25, Guennadi Liakhovetski wrote:
> Aha! A single thread? A specific asm insn? Is gcc --version enough to kill
> the machine? Or on smth like
> int main(void)
> {return 0;}
> gcc -E; gcc -S; gcc -c; ld? Step-by-step with gdb (hopefully, gdb doesn't
> have this insn...). NMI watchdog?

gcc -version is fine. A compile will cause the problem.

It should be noted that whilst a ./configure cycle is *guaranteed* to initiate 
the MCE, the MCE can occur on other (seemingly random) occasions.

This of course smacks of hardware failure, but not only are the components new 
I have also swapped them all (excluding graphics card.) And, don't forget, 
simple dual 'SMP' mode works fine too.

R
