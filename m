Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTLIWEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTLIWEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:04:44 -0500
Received: from legolas.restena.lu ([158.64.1.34]:28809 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263053AbTLIWEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:04:42 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Craig Bradney <cbradney@zip.com.au>
To: Ian Kumlien <pomac@vapor.com>
Cc: ross@datscreative.com.au, linux-kernel@vger.kernel.org, recbo@nishanet.com
In-Reply-To: <1070993538.1674.10.camel@big.pomac.com>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <200312081207.45297.ross@datscreative.com.au>
	 <1070993538.1674.10.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1071007478.5293.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 23:04:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 19:12, Ian Kumlien wrote:
> Bob wrote:
> > Using a patch that fixes a number of people's nforce2
> > lockups while enabling io-apic edge timer, I can now
> > use nmi_watchdog=2 but not =1
> 
> Why regurgitate patches that are outdated, Personally i find int
> outdated after Ross made his patches available and they DO enable
> nmi_watchdog=1. (I have seen the old patches mentioned more than once,
> if something better comes along, please move to that instead.)
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107080280512734&w=2
> 
> Anyways, Is there anyway to detect if the cpu is "disconnected" or, is
> there anyway to see when the kernel sends it's halts that triggers the
> disconnect? (or is it automagic?)
> 
> If there was a way to check, then thats all thats needed, all delays can
> be removed and the code can be more generalized.
> 
> (Since doubt that this is apic torment. It's more apic trying to talk to
> a disconnected cpu... (which both approaches hints at imho))

Have these patches been submitted for review for inclusion into the main
kernel?

I'm still running the old IO-APIC patch (Uptime 3d 20h) and having no
issues whatsoever.

Are all of the patches at that address you provide necessary? 

What do the IDE ones claim to fix? I have had no real issue with IDE at
all.. being able to burn CDs, DVDs, use my ATA133 drive for hdparm,
greps, compilation, and general use.....

Craig

