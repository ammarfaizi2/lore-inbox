Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbWBVAMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWBVAMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWBVAMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:12:19 -0500
Received: from rtr.ca ([64.26.128.89]:5845 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161260AbWBVAMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:12:17 -0500
Message-ID: <43FBAC6B.6030604@rtr.ca>
Date: Tue, 21 Feb 2006 19:12:27 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jens Axboe <axboe@suse.de>, Ariel Garcia <garcia@iwr.fzk.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de> <Pine.LNX.4.58.0602210903260.8603@shark.he.net> <43FBA907.6040906@rtr.ca> <Pine.LNX.4.58.0602211603510.8603@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602211603510.8603@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
>
> Thanks, good to have the continued feedback.
> It is SATA, right?  The latest patchset also includes PATA ACPI
> objects support (using libata), but it is missing a few calls
> to the functions that do the real work during resume.
> Will patch that this week also.

It's a PATA notebook drive, attached with some kind of hidden
bridge chip, to an Intel 82801FBM SATA ICH6M.

libata thinks it is pure SATA.

Cheers
