Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVCML1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVCML1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 06:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCML1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 06:27:13 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:48020 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261153AbVCML1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 06:27:09 -0500
Message-ID: <42342355.2080908@cogweb.net>
Date: Sun, 13 Mar 2005 03:26:13 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide0=ata66 doesn't seem obsolete
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On my laptop, idebus=66 or nothing gets me this:
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(33)

In contrast, ide0=ata66 gets me this (never mind the geometry):
ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=4864/255/63, UDMA(100)

What's not to like?

# uname -r
2.6.11.2

# lspci
0000:00:00.0 Host bridge: ALi Corporation M1671 Super P4 Northbridge 
[AGP4X,PCI and SDR/DDR] (rev 02)
0000:00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge 
[Aladdin IV]
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
0000:00:11.0 Bridge: ALi Corporation M7101 PMU

Cheers,
Dave

