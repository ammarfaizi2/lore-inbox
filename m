Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275055AbTHMOLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275052AbTHMOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:11:53 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:19192 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275055AbTHMOLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:11:52 -0400
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Ruben Puettmann <ruben@puettmann.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16186.14686.455795.927909@gargle.gargle.HOWL>
References: <20030813123119.GA25111@puettmann.net>
	 <16186.14686.455795.927909@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 15:11:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 14:13, Mikael Pettersson wrote:
> With APIC support enabled (SMP or UP_APIC), APM must be constrained:
> DISPLAY_BLANK off
> CPU_IDLE off
> built-in driver, not module

This isnt sufficient because some of the SMM traps off the FN-key 
sequences also crash thinkpads if APIC is enabled. Basically *dont use
local apic* except on SMP.


