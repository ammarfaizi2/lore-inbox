Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTE1DMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 23:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTE1DMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 23:12:19 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:58119 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S264486AbTE1DMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 23:12:17 -0400
Message-ID: <3ED42C48.2060803@snapgear.com>
Date: Wed, 28 May 2003 13:26:00 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.70-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.70.
Linus commited a bunch of patches over the last few days,
but I have a few more fixups to get through yet.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.70-uc0.patch.gz


Change Log:

. patch against 2.5.70                          me
. merge flat format shared lib support          David McCullough
. CONFIG_BOOT_PARAM for m68knommu               Bernardo Innocenti
. avoid ROMfs copy if not enabled               Bernardo Innocenti
. fix ColdFire serial irq handler return type   me
. separate m68knommu int setup code             Georges Menie
. Dragon Engine 2 start code fixups             Georges Menie
. fixup m68knommu do_fork() calls               me
. clean up m68knommu access_ok()                me
. simplify show_process_blocks() for !MMU       Bernardo Innocenti
. !MMU stubs for proc_pid_maps                  me

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com







