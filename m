Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933090AbWGASDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933090AbWGASDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933157AbWGASDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:03:06 -0400
Received: from mail.charite.de ([160.45.207.131]:23223 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S933090AbWGASDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:03:05 -0400
Date: Sat, 1 Jul 2006 20:03:00 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-ID: <20060701180300.GX13558@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060701175444.958D6E00608B@knarzkiste.dyndns.org> <20060701033524.3c478698.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060701033524.3c478698.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Starting with -mm4 and now with -mm5 I see:

> Jul  1 19:54:29 knarzkiste kernel: powernow-k8: Found 1 AMD Turion(tm) 64 Mobile Technology ML-30 processors (version 2.00.00)
> Jul  1 19:54:29 knarzkiste kernel: ACPI: Invalid package argument
> Jul  1 19:54:29 knarzkiste kernel: ACPI Exception (acpi_processor-0272): AE_BAD_PARAMETER, Invalid _PSS data [20060623]
> Jul  1 19:54:29 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12
> Jul  1 19:54:29 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4
> Jul  1 19:54:29 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8

I'm not sure if The "ACPI: Invalid package argument" and "ACPI Exception" are indicative of a real problem.

> Jul  1 19:54:15 knarzkiste kernel: CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
> Jul  1 19:54:15 knarzkiste kernel: Checking 'hlt' instruction... OK.
> Jul  1 19:54:15 knarzkiste kernel: ACPI: Core revision 20060623
> Jul  1 19:54:15 knarzkiste kernel: ENABLING IO-APIC IRQs

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
