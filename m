Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUKSWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUKSWdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUKSWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:30:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40949 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261670AbUKSWaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:30:04 -0500
Message-ID: <419E73E7.8080703@mvista.com>
Date: Fri, 19 Nov 2004 15:29:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Support for Artesyn Katana cPCI boards
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Artesyn Katana 750i, 752i, and 3750.

This patch depends on the Marvell host bridge support patch (mv64x60) 
[and the ev64260 platform support patch because the 2 patches touch the 
same Makefiles and Kconfig file but there are no code dependencies].

Note that the patch itself does not depend on the previously submitted 
MPSC driver but the platform does.  That is, to use the serial ports on 
those boards, the MPSC driver patch is required.

This patch is larger that 40KB so a link is provided (as per 
instructions in SubmittingPatches).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/katana.patch

