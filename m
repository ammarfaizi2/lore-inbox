Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTAMEHc>; Sun, 12 Jan 2003 23:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTAMEHc>; Sun, 12 Jan 2003 23:07:32 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:50962 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267806AbTAMEHb>; Sun, 12 Jan 2003 23:07:31 -0500
Message-ID: <3E223D8E.2020605@snapgear.com>
Date: Mon, 13 Jan 2003 14:16:14 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.56-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.56.
Back from vacation and more patches coming. Nothing much
new. Exception tables supported for m68knommu (as per Linus's
suggestion :-)

The bulk of this patch is still the merge of the linker
scripts, entry.S and startup code.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.56-uc0.patch.gz

Changelog:

1. patch against 2.5.56                  (me)
2. exeception tables for m68knommu       (me)
3. remove backwords code in mcfserial.h  (Adrian Bunk)

(I may have a missed a couple of updates here...)


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.56-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.56-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

