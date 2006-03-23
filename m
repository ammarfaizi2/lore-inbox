Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWCWBWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWCWBWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWCWBWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:22:01 -0500
Received: from mx0.karneval.cz ([81.27.192.107]:39089 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1751097AbWCWBWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:22:00 -0500
Message-ID: <4421F834.1070602@liberouter.org>
Date: Thu, 23 Mar 2006 02:21:56 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Francesco Biscani <biscani@pd.astro.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI error in 2.6.16
References: <200603222359.55631.biscani@pd.astro.it>
In-Reply-To: <200603222359.55631.biscani@pd.astro.it>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Francesco Biscani napsal(a):
> Hello,
> 
> sometimes at boot I get the following from the logs:
> 
> ACPI: write EC, IB not empty
> ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for 
> [EmbeddedControl] [20060127]
> ACPI Error (psparse-0517): Method parse/execution failed 
> [\_SB_.PCI0.ISA_.EC0_.SMRD] (Node c13ecd40), AE_TIME
> ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.UPBI] 
> (Node dbf42720), AE_TIME
> ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.CHBP] 
> (Node dbf42660), AE_TIME
> ACPI Error (psparse-0517): Method parse/execution failed 
> [\_SB_.PCI0.ISA_.EC0_.SMSL] (Node c13ecce0), AE_TIME
> ACPI Error (psparse-0517): Method parse/execution failed 
> [\_SB_.PCI0.ISA_.EC0_._Q09] (Node c13ecc40), AE_TIME
> 
> And after that the battery is reported as absent (even if it is physically 
> present). I get the impression that this happens when rebooting, not 
> from "cold powerons".
> 
> This did not happen in 2.6.15, it appeared somewhere in 2.6.16-rc series.
Could you post dmesgs of both, acpidump and .config? Could you bisect them?

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEIfg0MsxVwznUen4RApQaAKCRk+LUG+wasgLbeiNqAsfxyUsB0ACgkpNY
y23B68tNzhfKTCnEc+EYOTo=
=HjEW
-----END PGP SIGNATURE-----
