Return-Path: <linux-kernel-owner+w=401wt.eu-S964851AbWLNWB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWLNWB2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWLNWB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:01:28 -0500
Received: from deine-taler.de ([217.160.107.63]:54384 "EHLO
	p15091797.pureserver.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbWLNWB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:01:27 -0500
X-Greylist: delayed 1350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 17:01:27 EST
In-Reply-To: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>
References: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <341A1CE8-DF10-4CD5-B675-89449256EAB5@deine-taler.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Uli Kunitz <kune@deine-taler.de>
Subject: Re: [PATCH 2.6.19-git19] BUG due to bad argument to ieee80211softmac_assoc_work
Date: Thu, 14 Dec 2006 22:38:56 +0100
To: Michael Bommarito <mjbommar@umich.edu>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

I sent a patch to this list on Sunday, that patched the problem. It  
seems to be migrated into the wireless-2.6 git tree.

Regards,

Uli
Am 13.12.2006 um 19:17 schrieb Michael Bommarito:

> This didn't get much attention on bugzilla and I figured it was
> important enough to forward along to the whole list since it's been
> lingering around in ieee80211-softmac since 19-git5 at least.
> http://bugzilla.kernel.org/show_bug.cgi?id=7657
>
> Somebody was passing the whole mac device structure to
> ieee80211softmac_assoc_work instead of just the assocation work, which
> lead to much death and locking.
>
> Attached is a patch that fixes this (the actual change is two lines
> but context provided in patch for review).  The dmesg containing call
> trace is attached to the bugzilla entry above.
>
> -Mike
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Uli Kunitz



