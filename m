Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUBQIQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 03:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUBQIQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 03:16:15 -0500
Received: from aun.it.uu.se ([130.238.12.36]:59090 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262745AbUBQIQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 03:16:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16433.52683.105686.205893@alkaid.it.uu.se>
Date: Tue, 17 Feb 2004 09:16:11 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Tetsuji Rai <tetsuji_rai@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot enable APIC with 2.6.2
In-Reply-To: <4031731A.8020001@yahoo.com>
References: <403101BA.1060202@yahoo.com>
	<16433.19261.280849.983457@alkaid.it.uu.se>
	<4031731A.8020001@yahoo.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuji Rai writes:
 > Mikael Pettersson wrote:
 > > Tetsuji Rai writes:
 > >  > I enabled APIC in config file of kernel 2.6.2, however APIC is not enabled
 > >  > on boot.   I'm sure APIC is enabled on my machine by BIOS, because I
 > >  > confirmed it with WIndows XP.  What's wrong with my settings?   Or it's a
 > >  > bug of kernel?.....I suspect my config should be wrong.....
 > > 
 > > "APIC" here means I/O-APIC. The local APIC is Ok according to the dmesg log.
...
 > > But here the .config ends, so we can't tell if ACPI is enabled or not.
...
 > Okey!!  I attach my config file (config-2.6.2) to this email as an
 > attachment.  And yes my machine is overclocked by 8 percent :)
...
 > # ACPI (Advanced Configuration and Power Interface) Support
 > #
 > # CONFIG_ACPI is not set

ACPI is disabled. Enable it and try again.
