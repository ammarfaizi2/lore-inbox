Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTDKNEU (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTDKNEU (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 09:04:20 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:55532 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP id S264357AbTDKNES (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 09:04:18 -0400
Message-ID: <3E96C09F.3020105@snapgear.com>
Date: Fri, 11 Apr 2003 23:18:23 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.67-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.67.
Pretty small set of patches to fix various minor problems.
All uClinux support is in the mainline now, so these patches
are purely fixes.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.67-uc0.patch.gz

Change log:

. updated defconfig for the m68knommu arch
. ColdFire serial driver and console clean ups
. fix ColdFire timer warnings
. remove some inline mm stubs (specific to mmu-less support) from mm.h


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.67-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.67-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

















