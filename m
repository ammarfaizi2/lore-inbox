Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTLOK53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTLOK53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:57:29 -0500
Received: from mail2.neceur.com ([193.116.254.4]:16089 "EHLO mail2.neceur.com")
	by vger.kernel.org with ESMTP id S263468AbTLOK52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:57:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OFAC3015E2.784FA52E-ON80256DFD.003A2DB1-80256DFD.003C2F2D@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Mon, 15 Dec 2003 10:57:16 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/15/2003 10:57:17 AM,
	Serialize complete at 12/15/2003 10:57:17 AM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 15/12/2003 10:52:52,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 15/12/2003 10:52:54,
	Serialize complete at 15/12/2003 10:52:54
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just a quick note saying I've been running my nforce2 for nearly four
days with considerable I/O and no trouble.

Processor: AMD Athlon XP 2700+
MB: ASUS A7N8X Deluxe
APCI: Turned off in kernel config
Boot params: acpi=off noapic
Kernel: 2.6.0-test11-bk7 + disconnect quirk patch

I still have a considerable number of spurious IRQs (but < 1%
compared to IRQ0 / LINT).  I'm not running the timer patch
at all.

I will try with latest bk kernel + disconnect  + acpi compiled in.

Questions.

1) Does anybody know the state of play ala 2.6.0 release and which
patches we can get in?

2) If the local apic is running is it necessary to use the 8254 as a 
timer?

3) Does anybody, anywhere, have any nvidia documentation and
is it worth trying to bully them into releasing some?

Cheers,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."
