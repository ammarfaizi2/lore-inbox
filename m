Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRDJSHy>; Tue, 10 Apr 2001 14:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDJSHo>; Tue, 10 Apr 2001 14:07:44 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:38416 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130820AbRDJSHa>; Tue, 10 Apr 2001 14:07:30 -0400
Date: Tue, 10 Apr 2001 13:01:07 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Manuel A. McLure" <mmt@unify.com>
cc: "'Axel Thimm'" <Axel.Thimm@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Still IRQ routing problems with VIA
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A1@pcmailsrv1.sac.unify.com>
Message-ID: <Pine.LNX.3.96.1010410125456.26863A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Manuel A. McLure wrote:
> This may be the difference - I always set "Plug-n-Play OS: No" on all my
> machines. Linux works fine and it doesn't seem to hurt Windows 98 any.

Correct, it's perfectly fine to do that on all machines (not just Via).
Users should also set "PNP OS: No" for Linux 2.2...

Other BIOS settings to verify:
Assign IRQ to VGA: no (optional, but you probably don't need a VGA IRQ)
Operating System: other (or Unix, depending on the BIOS)
Memory hole: no

Unless you are using ISA cards, make sure all your PCI plug-n-play
IRQ settings are set to "PCI/PnP" not "ISA/ICU".

hmmm, maybe I should write a Linux kernel BIOS guide/FAQ...

	Jeff



