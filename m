Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWARFTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWARFTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWARFTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:19:06 -0500
Received: from mail.dvmed.net ([216.237.124.58]:36018 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030240AbWARFTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:19:04 -0500
Message-ID: <43CDCFC1.2000008@pobox.com>
Date: Wed, 18 Jan 2006 00:18:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: [git patches] 2.6.x libata updates
References: <20060118021530.GA23108@havoc.gtf.org> <20060117183318.1031c0d2.akpm@osdl.org>
In-Reply-To: <20060117183318.1031c0d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Morton wrote: > Jeff Garzik <jgarzik@pobox.com>
	wrote: > >> Please pull from 'upstream-linus' branch of >>
	master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git > >
	> I worry that whatever it is which has busted Reuben's machine will
	leak > into mainline. This patch probably isn't it. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> 
> I worry that whatever it is which has busted Reuben's machine will leak
> into mainline.  This patch probably isn't it.

Nothing at all in this push is remotely controversial...


> I guess if we can feed libata and acpi into mainline in little bits and
> pieces like this, that'll help us work out the cause.
> 
> Reuben has spent ages bisecting lots of patches, but the bug is quite
> intermittent, which makes the process quite maddeningly error-prone and
> slow.
> 
> Then again, perhaps merging it up is the best way of fixing it: someone out
> there will hit the thing more repeatably and will have a better shot at
> finding the cause.

Well, I haven't even looked at ACPI yet, and the Jens/Tejun stuff didn't 
get much testing at all.  There's a lot of unfamiliar stuff in the mix.

	Jeff


