Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSK1FD0>; Thu, 28 Nov 2002 00:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbSK1FD0>; Thu, 28 Nov 2002 00:03:26 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:27353 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S264856AbSK1FDZ>; Thu, 28 Nov 2002 00:03:25 -0500
Message-ID: <3DE5A1E4.8030200@snapgear.com>
Date: Thu, 28 Nov 2002 14:56:04 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.50-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Mostly the same patches as previously, only patches against
2.5.50. I will keep sending small peices to Linus, hopefully
he will commit them some time...

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.50-uc0.patch.gz

Change log:
1. patch up to 2.5.50                              (me)
2. spinlocks around m68knommu signal processing    (Robert Daniels)
3. pte_chain_unlock fix up for !CONFIG_SWAP        (Andrew Morton)
4. !CONFIG_MMU read_zero() rewrite                 (Andrew Morton)


I have separated out the 68328 frame buffer driver.
Its patch set is now at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.50-uc0-68328fb.patch.gz

And the h8300 support is at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.50-uc0-h8300.patch.gz

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com










