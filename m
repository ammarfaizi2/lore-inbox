Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWAPDBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWAPDBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 22:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWAPDBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 22:01:34 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:63414 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932178AbWAPDBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 22:01:34 -0500
Message-ID: <43CB0C81.1030605@cfl.rr.com>
Date: Sun, 15 Jan 2006 22:01:21 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com> <43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com> <43C982C0.1070605@cfl.rr.com> <m3r779z9on.fsf@telia.com> <m31wz9yuoh.fsf@telia.com>
In-Reply-To: <m31wz9yuoh.fsf@telia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this:

drivers/block/pktcdvd.c:1992: error: label ‘out_unclaim’ used but not 
defined

Also the patch did not cleanly apply. It looks like you didn't get all 
of your changes into the diff. Unless you have some other patches that I 
don't? This is against 2.6.15 right?

Peter Osterlund wrote:

>Here is the patch. It works as expected so far in my tests.
>
>
>pktcdvd: Don't waste kernel memory.
>
>From: Peter Osterlund <petero2@telia.com>
>
>Allocate memory for read-gathering at open time, when it is known just
>how much memory is needed.  This avoids wasting kernel memory when the
>real packet size is smaller than the maximum packet size supported by
>the driver.
>
>Signed-off-by: Peter Osterlund <petero2@telia.com>
>---
>
>  
>

