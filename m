Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVJDHGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVJDHGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVJDHGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:06:15 -0400
Received: from s-smtp-osl-01.bluecom.no ([62.101.193.35]:65200 "EHLO
	s-smtp-osl-01.bluecom.no") by vger.kernel.org with ESMTP
	id S932448AbVJDHGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:06:14 -0400
Message-ID: <2484.81.191.59.180.1128409573.squirrel@webmail.bluecom.no>
Date: Tue, 4 Oct 2005 09:06:13 +0200 (CEST)
Subject: it87x / buggy bios workaround
From: "Marius Schrecker" <marius@schrecker.org>
To: linux-kernel@vger.kernel.org
Reply-To: marius@schrecker.org
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I'm sorry to bother the list with stupid end-use questions, but am
stuck trying to find the patch to work around this. I'll disappear
quietly if someone gan help me ;-).

I have a Biostar K8NBD-S9 motherboard with the IT8712F super i/o chip.

The board suffers from the buggy BIOS which causes the manual PWM feature
of the chip to be unreliable to initialize.

After much googling I found this thread which indicates that Jonas Munsin
and Jean Delvare were working on a workaround for this back in January:

 http://lkml.org/lkml/2005/1/14/94

The thread also suggests that the patch was destined for the -mm tree.

I have looked as well as I can at the 2.6.14 -mm patches, but can't see
any reference to it87.

Currently running 2.6.13 vanilla (with some patches). The it87 driver
seems to implement the bug testing function which Jonas and Jean were
talking about in the 2.6.10 /2.6.11 days, but doesn't conatin any
workaround beyond disabling PWM once the problem is identified.

Can anyone tell me if a patch against 2.6.13 exists (or whether it is
implemented in some flavour of 2.6.13 / 2.6.14), or how possibly to
customize my own module code to initialize pwm for my board (this will be
a htpc frontend box so I really need the quietness)?


Many thanks


Marius Schrecker

