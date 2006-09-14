Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWINUK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWINUK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWINUK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:10:27 -0400
Received: from diedas.soften.ktu.lt ([193.219.33.197]:55685 "EHLO
	diedas.soften.ktu.lt") by vger.kernel.org with ESMTP
	id S1751119AbWINUK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:10:26 -0400
Date: Thu, 14 Sep 2006 23:13:53 +0300 (EEST)
From: Almonas Petrasevicius <draugaz@diedas.soften.ktu.lt>
To: Pallipadi@diedas.soften.ktu.lt, Venkatesh <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, Ben B <kernel@bb.cactii.net>,
       davej@codemonkey.org.uk
Subject: Re: speedstep-centrino broke
In-Reply-To: <20060914142242.GA28040@cactii.net>
Message-ID: <Pine.LNX.4.62.0609142250300.31136@diedas.soften.ktu.lt>
References: <Pine.LNX.4.62.0609141558090.22822@diedas.soften.ktu.lt>
 <20060914142242.GA28040@cactii.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2006-09-14 at 12:43 -0700, Pallipadi, Venkatesh wrote:

> >Or maybe I don't know how to look.
> >Could You dump your "working" ACPI table and look for those
> >two methods?
>
> As you mentioned in your earlier mail, CpuPm object is missing after
> BIOS update. That table, most probably, will contain these ACPI _PSS etc
> methods internally.

That's my problem: I can't find them there. At least not directly.
It contains just two methods for each CPU: _PDC and _OSC.
Althrough the _OSC methods contain some logic and Load(...) calls, and 
there is a package supiciously looking like a directory containing 
some additional ACPI tables (for example "CPU0IST ", offset, length and so 
on). So, it's possible, that required tables are loaded "on demand" but 
not accesible with the acpidump.

Regards,
Almonas
