Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVFVCmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVFVCmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 22:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVFVCmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 22:42:44 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:25050 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262523AbVFVCml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 22:42:41 -0400
Date: Tue, 21 Jun 2005 22:42:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050621201742.GA16400@kvack.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Ingo Molnar <mingo@elte.hu>,
       William Weston <weston@sysex.net>, "K.R. Foley" <kr@cybsft.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Message-id: <200506212242.39113.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu> <20050621131009.GA22691@elte.hu>
 <20050621201742.GA16400@kvack.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 16:17, Benjamin LaHaise wrote:
>On Tue, Jun 21, 2005 at 03:10:09PM +0200, Ingo Molnar wrote:
>> find the patch below - it's also included in the -50-05 -RT tree i
>> just uploaded. Can you confirm that you dont get the warnings in
>> the -50-05 (and later) -RT kernels?
>
>Looks good.  Acked-by: Benjamin LaHaise <bcrl@kvack.org>
>
>  -ben

FWIW, 50-06 is running clean here with mode 3 & no hardirq threading.  
Uptime is about 9 hours.

Would it do any good to try mode 4 & see if tvtime still runs?  
Previously, I got the impression that was a dma problem & posted some 
of the logs, but I've not noted any fixes for that go by.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
