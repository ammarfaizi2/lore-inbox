Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTEENSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTEENSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:18:43 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:59882 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP id S262182AbTEENSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:18:42 -0400
Message-ID: <3EB66859.7050305@snapgear.com>
Date: Mon, 05 May 2003 23:34:17 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.69-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.69.
Also in this patch I have added support for the new Motorola
M5282 ColdFire processor.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.69-uc0.patch.gz

Change log:

. Motorola M5282 ColdFire CPU support             (me)
. fix get_user_pages to return vma dummy pointer  (David McCullough)
. updated defconfig for the m68knommu arch        (me)
. ColdFire serial driver and console clean ups    (me)
. start conversion to new style serial driver     (me)
. fix ColdFire timer warnings                     (me)
. improved Dragon Engine 2 support                (Georges Menie)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com



















