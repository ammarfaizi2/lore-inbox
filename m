Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWHYGIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWHYGIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWHYGIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:08:34 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:60376 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750704AbWHYGId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:08:33 -0400
Date: Fri, 25 Aug 2006 08:04:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
In-Reply-To: <20060824164808.GN19810@stusta.de>
Message-ID: <Pine.LNX.4.61.0608250803060.7912@yvahk01.tjqt.qr>
References: <32640.1156424442@warthog.cambridge.redhat.com>
 <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org>
 <20060824155814.GL19810@stusta.de> <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
 <20060824164808.GN19810@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Then that should be CONFIG_I_AM_AN_EXPERT (CONFIG_EXPERT), not 
>> CONFIG_EMBEDDED.
>
>It makes sense that there is one option only for additional space 
>savings.
>
>But you are right, we need a second option for not space related expert 
>options.

The question is whether CONFIG_BLOCK is
 - a space-saving option
 - or an expert option
or both? Maybe one should only be able to disable it when both 
CONFIG_EXPERT=y and CONFIG_EMBEDDED=y. What are you thinking?



Jan Engelhardt
-- 
