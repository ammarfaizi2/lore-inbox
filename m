Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTEHNNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbTEHNNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:13:20 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:35544 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP id S261570AbTEHNNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:13:17 -0400
Message-ID: <3F06CF6E.7090803@snapgear.com>
Date: Sat, 05 Jul 2003 23:15:26 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.69-uc1 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Another update of the uClinux (MMU-less) fixups against 2.5.69.
This includes some of the missing m5282 CPU support, and fixes
gettimeofday() to be microsecond accurate.

You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.69-uc1.patch.gz


Change log:

. Motorola M5282 ColdFire CPU support             (me)
. FEC ethernet driver support for 5282            (me)
. fix get_user_pages to return vma dummy pointer  (David McCullough)
. updated defconfig for the m68knommu arch        (me)
. ColdFire serial driver and console clean ups    (me)
   (also includes 5282 support)
. start conversion to new style serial driver     (me)
. fix ColdFire timer warnings                     (me)
. improved Dragon Engine 2 support                (Georges Menie)
. implement timer offset calculation              (me)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com




















