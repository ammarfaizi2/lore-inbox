Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWCWCiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWCWCiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 21:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWCWCiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 21:38:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964897AbWCWCiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 21:38:24 -0500
Date: Wed, 22 Mar 2006 18:34:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <slaby@liberouter.org>
Cc: biscani@pd.astro.it, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: ACPI error in 2.6.16
Message-Id: <20060322183455.32a385e5.akpm@osdl.org>
In-Reply-To: <4421F834.1070602@liberouter.org>
References: <200603222359.55631.biscani@pd.astro.it>
	<4421F834.1070602@liberouter.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <slaby@liberouter.org> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Francesco Biscani napsal(a):
> > Hello,
> > 
> > sometimes at boot I get the following from the logs:
> > 
> > ACPI: write EC, IB not empty
> > ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for 
> > [EmbeddedControl] [20060127]
> > ACPI Error (psparse-0517): Method parse/execution failed 
> > [\_SB_.PCI0.ISA_.EC0_.SMRD] (Node c13ecd40), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.UPBI] 
> > (Node dbf42720), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.CHBP] 
> > (Node dbf42660), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed 
> > [\_SB_.PCI0.ISA_.EC0_.SMSL] (Node c13ecce0), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed 
> > [\_SB_.PCI0.ISA_.EC0_._Q09] (Node c13ecc40), AE_TIME
> > 
> > And after that the battery is reported as absent (even if it is physically 
> > present). I get the impression that this happens when rebooting, not 
> > from "cold powerons".
> > 
> > This did not happen in 2.6.15, it appeared somewhere in 2.6.16-rc series.
> Could you post dmesgs of both, acpidump and .config? Could you bisect them?
> 

And please Cc: linux-acpi@vger.kernel.org, thanks.
