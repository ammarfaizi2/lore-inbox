Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRADUM7>; Thu, 4 Jan 2001 15:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRADUMt>; Thu, 4 Jan 2001 15:12:49 -0500
Received: from Cantor.suse.de ([194.112.123.193]:37384 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132548AbRADUMc>;
	Thu, 4 Jan 2001 15:12:32 -0500
Date: Thu, 4 Jan 2001 21:09:36 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: How to power off with ACPI/APM?
To: crawford@goingware.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A53905B.FA785099@goingware.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010104211144.0B74F51AA@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Jan, Michael D. Crawford wrote:

> Looking back in the ACPI kernel config help, it says you can use ACPI
> if you also have APM enabled, which I didn't do at first.

 That's wrong then, you can't use ACPI and APM at the same time.

> I enabled
> it, and the "S5 failed" message goes away at the end, but my machine
> still doesn't power down. I notice in the kernel messages at boot
> time that ACPI says something like "APM already enabled, exiting".

 ACPI doesn't work very well. If you just want your machine powered
 off automatically you might want to try just APM.

-- 

Servus,
       Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
