Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbUJ1Bsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbUJ1Bsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbUJ1Bsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:48:41 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:33553 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S262691AbUJ1Bsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:48:33 -0400
Message-ID: <41804FBC.6000002@snapgear.com>
Date: Thu, 28 Oct 2004 11:47:40 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.9-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.9.

Some new things in this. I have done some work to
support the new Freescale ColdFire 5274/5275 CPU's.
And quite a few small fixes in there too.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.9-uc0.patch.gz


Change log:

. import of linux-2.6.9                        <gerg@snapgear.com>
. support Freescale 5274/5275 family           <gerg@snapgear.com>
. sync m68knommu  system call table with m68k  <geert@linux-m68k.org>
. clean out m68knommu HZ setup defines         <gerg@snapgear.com>
. fix time offset calculate for PIT hardware   <gerg@snapgear.com>
. support 2 devices in FEC ethernet driver     <gerg@snapgear.com>
. fix coldfire stack unwind on signal exit     <H.Haeberle@pilz.de>
. fix udelay overflow on fast ColdFire CPU's   <gerg@snapgear.com>
. cleanup m68knommu signal handling            <gerg@snapgear.com>
. Sneha platform support (m68knommu)           <jorge.borrego@gmail.com>

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
