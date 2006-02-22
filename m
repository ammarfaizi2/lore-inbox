Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161255AbWBVAFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWBVAFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWBVAFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:05:06 -0500
Received: from xenotime.net ([66.160.160.81]:53212 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161255AbWBVAFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:05:04 -0500
Date: Tue, 21 Feb 2006 16:05:03 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mark Lord <lkml@rtr.ca>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jens Axboe <axboe@suse.de>,
       Ariel Garcia <garcia@iwr.fzk.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
In-Reply-To: <43FBA907.6040906@rtr.ca>
Message-ID: <Pine.LNX.4.58.0602211603510.8603@shark.he.net>
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de>
 <Pine.LNX.4.58.0602210903260.8603@shark.he.net> <43FBA907.6040906@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Mark Lord wrote:

> Hi Randy,
>
> Just to let you know that my Dell i9300 (still!) suspends/resumes (RAM, Disk)
> perfectly 100% with your patches applied.
>
> And fails regularly without them.  2.6.16-rc4.
>
> Cheers

Thanks, good to have the continued feedback.
It is SATA, right?  The latest patchset also includes PATA ACPI
objects support (using libata), but it is missing a few calls
to the functions that do the real work during resume.
Will patch that this week also.

-- 
~Randy
