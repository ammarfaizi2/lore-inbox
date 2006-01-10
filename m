Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWAJHOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWAJHOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWAJHOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:14:39 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:16900 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1750939AbWAJHOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:14:38 -0500
Message-ID: <43C35F0B.8010409@snapgear.com>
Date: Tue, 10 Jan 2006 17:15:23 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.15-uc0 (MMU-less support)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.15.

Only a few new fixes to be merged. Not much outstanding at
the moment.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.15-uc0.patch.gz


Change log:

. import of 2.6.15                                 Greg Ungerer
. adjust irq level/priority for coldfire serial    Greg Ungerer
. remove m68knommu mach_irq_*                      Christoph Hellwig
. save/restore a5 reg properly through signals     Stuart Hughes
. delay trace output from binfmt_flat              Stuart Hughes
. fix m68knommu find_next_zero_bit                 Sascha Smejkal
. fix linker script ram length m5208evb            Milton Miller


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com






