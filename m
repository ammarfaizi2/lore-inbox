Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUI0GcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUI0GcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUI0GcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 02:32:12 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:48547 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S266183AbUI0GcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 02:32:09 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 02:31:54 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net> <20040926221317.2e2d0be5.akpm@osdl.org>
In-Reply-To: <20040926221317.2e2d0be5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200409270231.55551.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.42.203] at Mon, 27 Sep 2004 01:32:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 01:13, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>>  The bootup hangs, from dmesg after reboot to 2.6.9-rc2-mm3:
>>
>>  Checking 'hlt' instruction... OK.
>>  -----
>>  2.6.9-rc2-mm4 hangs here, and never gets to the next line
>>  -----
>>  NET: Registered protocol family 16
>>
>>  So I assume something in the next line hangs it. Sysrq-t has no
>>  repsonse, must use the hardware reset button.
>
>Try booting with `acpi=off'

Its already off in the .config, theres nothing there I need.

>Try reverting allow-multiple-inputs-in-alternative_input.patch

Ok, I´ll give that a shot.  Thanks.

I also note that the agp, radeon & drm stuff is pretty noisy, 
deprecated this and deprecated that warnings.
Also, amanda has started, so I´ll not be rebooting till morning to 
test the reverted patch.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
