Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSKEHmK>; Tue, 5 Nov 2002 02:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSKEHmK>; Tue, 5 Nov 2002 02:42:10 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:1222 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S263283AbSKEHmJ>; Tue, 5 Nov 2002 02:42:09 -0500
Message-ID: <3DC77832.6040600@snapgear.com>
Date: Tue, 05 Nov 2002 17:50:10 +1000
From: gerg@snapgear.com
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.46-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Here is a much reduced set of MMU-less fixups for 2.5.46 :-)
Now that the majority of the code is in there is just a few
little things missing and some clean ups.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0.patch.gz

Change log:
1. patch against 2.5.46
2. add MAC setting support to fec driver
3. clean up ColdFire entry.S (more to come)


You can get smaller patches here:

. FEC (5272) patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0-fec.patch.gz

. 68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0-serial.patch.gz

. 68328 frame buffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0-fb.patch.gz

. m68knommu patches
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0-m68knommu.patch.gz

. v850 patches
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0-v850.patch.gz

. missing no MM peices (some mm/, /kernel and /fs/proc files)
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc0-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com






