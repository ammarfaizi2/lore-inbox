Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310333AbSCKSRW>; Mon, 11 Mar 2002 13:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310364AbSCKSRM>; Mon, 11 Mar 2002 13:17:12 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:5853 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S310333AbSCKSRI>; Mon, 11 Mar 2002 13:17:08 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7CCE@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Wolly'" <wwolly@gmx.net>, acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: RE: [patch] minimal ACPI bugfix
Date: Mon, 11 Mar 2002 10:17:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Wolly [mailto:wwolly@gmx.net]
> "Avoid creating multiple /proc entries when (buggy) ACPI
> BIOS tables erroneously list both fixed- and generic-
> feature buttons."
> While the function already prints a disgnostic message 
> on this and registers the new button dir in /proc, it fails to 
> remove the old one. 

> Patch is against 2.4.18 kernel;
> patched file sm_osl.c is in drivers/acpi/ospm/button/

Hi Wolly,

ACPI development is happening out of the mainline for now, until it
stabilizes. Please try the latest patches available at
http://sf.net/projects/acpi . AFAIK the button thing is fixed in the latest
ACPI patch, although the sysrq hookup feature is new, so that is definitely
useful code, thanks.

Regards -- Andy
