Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVATK74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVATK74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 05:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVATK74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 05:59:56 -0500
Received: from gprs215-87.eurotel.cz ([160.218.215.87]:33498 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262114AbVATK7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 05:59:42 -0500
Date: Thu, 20 Jan 2005 11:59:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Fred Labrosse <ffl@aber.ac.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Machine no longer enters C3 on 2.6.11-rc1-bk
Message-ID: <20050120105911.GF1452@elf.ucw.cz>
References: <20050120104033.GA25889@elf.ucw.cz> <16879.36609.94551.926755@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16879.36609.94551.926755@aber.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > bus master activity: is changing all the time, mostly 555555555 and
>  > aaaaaaa, and cpu refuses to enter C3 for obvious reasons. I compiled
>  > out USB and sound... Does anybody else see the same problem?
>  > 
> 
> I did notice too that it was never in C3 apart from a bit right at the
> beginning, since 2.6.10.  It has always been like that up to 2.6.6, became
> better from 2.6.7 (but had other problems with that).

Good, so I'm not alone.

> P.S.  I didn't check bus master activity.  How do you do that?

cat /proc/acpi/processor/*/power

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
