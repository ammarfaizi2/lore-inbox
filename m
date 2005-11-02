Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbVKBEAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbVKBEAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 23:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVKBEAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 23:00:39 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:29966 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1751486AbVKBEAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 23:00:38 -0500
Message-ID: <43683A03.9010104@snapgear.com>
Date: Wed, 02 Nov 2005 14:01:07 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.14-uc0 (MMU-less support)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.14.

Some new platform support, for the 5207/5208 ColdFire parts.
A few bug fixes and some other minor cleanups.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.14-uc0.patch.gz


Change log:

. merge with 2.6.14                             <gerg@uclinux.org>
. remove some MAGIC_ROM_PTR code                <gerg@uclinux.org>
. ColdFire 5208 support                         Matt Wadell
. fix module loading                            <gerg@uclinux.org>
. re-order FEC ethernet init sequence           <gerg@uclinux.org>
. FEC ethernet phy and restart fixes            Philippe De Muyter
. change names "Motorola" -> "Freescale"        <gerg@uclinux.org>
. remove generated asm-offsets.h file           <gerg@uclinux.org>
. remove unmaintained asm-m68knommu/ide.h       <gerg@uclinux.org>
. change "extern inline" -> "static inline"     Adrian Bunk


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com





