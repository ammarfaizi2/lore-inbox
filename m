Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUI2IOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUI2IOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUI2IOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:14:33 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:60241 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268216AbUI2IOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:14:31 -0400
Message-ID: <415A6EE6.1090404@blueyonder.co.uk>
Date: Wed, 29 Sep 2004 09:14:30 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm4 and nvidia 1.0-6111
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2004 08:14:55.0950 (UTC) FILETIME=[67785EE0:01C4A5FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The usual patches applied that made it work with -mm3.
Changed all instances of NV_REMAP_PAGE_RANGE to NV_REMAP_PFN_RANGE and 
nv_remap_page_range to nv_remap_pfn_range in nv.c, nv-linux.h,
os-agp.c and os-interface.c as redifined in 
/usr/src/linux-2.6.9-rc2-mm4/include/linux/mm.h.
The module builds and installs without problems, but on init 5, I get 
thrown back to vt1, /var/log/XFree86.0.log gives the error:-
(--) NVIDIA(0): Linear framebuffer at 0xD8000000
(--) NVIDIA(0): MMIO registers at 0xE1000000
(II) NVIDIA(0): NVIDIA GPU detected as: GeForce FX 5200
(--) NVIDIA(0): VideoBIOS: 04.34.20.42.01
(--) NVIDIA(0): Interlaced video modes are supported on this GPU
(II) NVIDIA(0): Detected AGP rate: 8X
(EE) NVIDIA(0): Failed to allocate config DMA context
(II) UnloadModule: "nvidia"
(II) UnloadModule: "vgahw"
(II) Unloading /usr/X11R6/lib/modules/libvgahw.a
(EE) Screen(s) found, but none have a usable configuration.

Fatal server error:
no screens found
-------------------------------
Any help appreciated, also posted to nvidia forum.

Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
