Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWHXQnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWHXQnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWHXQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:43:50 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:7552 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030378AbWHXQnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:43:49 -0400
Date: Thu, 24 Aug 2006 18:39:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
In-Reply-To: <20060824155814.GL19810@stusta.de>
Message-ID: <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
References: <32640.1156424442@warthog.cambridge.redhat.com>
 <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org>
 <20060824155814.GL19810@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Thu, 2006-08-24 at 17:29 +0200, Adrian Bunk wrote:
>> >         bool "Enable the block layer" depends on EMBEDDED 
>> 
>> Please. no. CONFIG_EMBEDDED was a bad idea in the first place -- its
>> sole purpose is to pander to Aunt Tillie.
>
>It's not for Aunt Tillie.
>It's for an average system administrator who compiles his own kernel.
>
>CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
>possible, and I really know what I'm doing" people.

Then that should be CONFIG_I_AM_AN_EXPERT (CONFIG_EXPERT), not 
CONFIG_EMBEDDED.

>There's no reason for getting linux-kernel swamped with
>"my kernel doesn't boot" messages by people who accidentally disabled 
>this option.

Jan Engelhardt
-- 
