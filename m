Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272339AbTHNNVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 09:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272341AbTHNNVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 09:21:21 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:24750 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272339AbTHNNVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 09:21:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16187.36046.209532.255482@gargle.gargle.HOWL>
Date: Thu, 14 Aug 2003 15:21:18 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
In-Reply-To: <20030814122845.GA2264@puettmann.net>
References: <20030813123119.GA25111@puettmann.net>
	<16186.14686.455795.927909@gargle.gargle.HOWL>
	<1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
	<20030814122845.GA2264@puettmann.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann writes:
 > On Wed, Aug 13, 2003 at 03:11:27PM +0100, Alan Cox wrote:
 > > On Mer, 2003-08-13 at 14:13, Mikael Pettersson wrote:
 > > > With APIC support enabled (SMP or UP_APIC), APM must be constrained:
 > > > DISPLAY_BLANK off
 > > > CPU_IDLE off
 > > > built-in driver, not module
 > > 
 > > This isnt sufficient because some of the SMM traps off the FN-key 
 > > sequences also crash thinkpads if APIC is enabled. Basically *dont use
 > > local apic* except on SMP.
 > 
 > sorry but why breaks this all under linux? O.K im not a friend if
 > windows but on the preinstalled windowsXP it runs all fine.

Because Winblows typically won't attempt to use the local APIC
on uniprocessor machines.

 > Is this a problem of manpower or missing spec's? 

BIOS limitations or bugs (depending on your POV)

It tends to work on desktop machines but break on laptops.
