Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbULMQSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbULMQSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULMQPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:15:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9345 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261262AbULMQMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:12:08 -0500
Date: Mon, 13 Dec 2004 17:12:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hans Kristian Rosbach <hk@isphuset.no>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213161207.GA27352@atrey.karlin.mff.cuni.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local> <20041213112229.GS6272@elf.ucw.cz> <1102942270.17225.81.camel@linux.local> <Pine.GSO.4.61.0412131605180.16849@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0412131605180.16849@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > I'm not sure what the above "scedule_timeout(HZ/10)" is supposed to
> > do, but the parameter it gets in 1000hz is "100" so I assume this
> > is because we want to wait for 100ms, and in 1000hz that equals
> > 100 cycles. Correct?
> 
> `schedule_timeout(HZ/x)' lets it wait for 1/x'th second.

...small problem is that for HZ lower than x it does not wait at all
:-(.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
