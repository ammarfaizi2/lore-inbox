Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275414AbTHNRer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275411AbTHNRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:34:43 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54912 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275412AbTHNRdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:33:36 -0400
Date: Thu, 14 Aug 2003 18:33:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Ruben Puettmann <ruben@puettmann.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
Message-ID: <20030814173327.GB10889@mail.jlokier.co.uk>
References: <20030813123119.GA25111@puettmann.net> <16186.14686.455795.927909@gargle.gargle.HOWL> <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-08-13 at 14:13, Mikael Pettersson wrote:
> > With APIC support enabled (SMP or UP_APIC), APM must be constrained:
> > DISPLAY_BLANK off
> > CPU_IDLE off
> > built-in driver, not module
> 
> This isnt sufficient because some of the SMM traps off the FN-key 
> sequences also crash thinkpads if APIC is enabled. Basically *dont use
> local apic* except on SMP.

Is it feasible to disable the APIC during BIOS calls,?

If that's feasible, it could fix the APM problem though not the SMM
trap problem on Thinkpads.

-- Jamie
