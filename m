Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUIOF12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUIOF12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 01:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUIOF12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 01:27:28 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:43022 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S267526AbUIOF1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 01:27:25 -0400
Message-ID: <4147D243.5000401@snapgear.com>
Date: Wed, 15 Sep 2004 15:25:23 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.8.1-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.8.1.
I know this is a little late (hey, I have been on vacation :-)

A few new things in this. I have done a bunch of work to
support the new Freescale (was Motorola) 5270/5271 CPU's.
And the usual few small fixes too.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.8.1-uc0.patch.gz

Change log:

. import of linux-2.6.8.1                            <gerg@snapgear.com>
. added support for the Freescale 5270/5271 family   <gerg@snapgear.com>
. make 5282 support generic (528x) to include 5280   <gerg@snapgear.com>
. synced system call table with m68k                 <gerg@snapgear.com>
. merged latest armnommu support                 <hyok.choi@samsung.com>
. code to apply relocation adds on module load
                                       <christian.magnusson@runaware.com>
. auto-size memory on the M5206eC3 board
                                       <christian.magnusson@runaware.com>
. fix timeout duration for breaks in ColdFire serial
                                       <christian.magnusson@runaware.com>



Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com
























