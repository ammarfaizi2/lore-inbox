Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTHGPdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHGPaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:30:04 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:26525 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S269981AbTHGP2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:28:31 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Mike Dresser" <mdresser_l@windsormachine.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
Date: Thu, 7 Aug 2003 11:40:12 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGOEPPCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <Pine.LNX.4.56.0308071108110.18325@router.windsormachine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

Actually, using APM was not done on purpose.  It was configured in already
from our Red Hat 9 install.  We really don't need any Power Management at
all, since it is not a lap top.  I have not tried the ACPI at all.  I did
try the allow_ints feature (test #5), but it still locked up.  From this
test I gathered that it was not some "cli" that was never undone.  So maybe
the BIOS hoses something?

>5) Power Management disabled in BIOS							locked up after a few minutes
>   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y
>   Kernel parameter passed in: amp=allow_ints

Kathy


-----Original Message-----
From: Mike Dresser [mailto:mdresser_l@windsormachine.com]
Sent: Thursday, August 07, 2003 10:11 AM
To: Kathy Frazier
Cc: linux-kernel@vger.kernel.org
Subject: Re: [APM] CPU idle calls causing problem with ASUS P4PE MoBo


<snip>

I'm curious why you are using the APM method.

Have you tried ACPI(which replaced APM a long time ago)

And also out of curiosity, have you played with the config_apm_allow_ints?

Mike

