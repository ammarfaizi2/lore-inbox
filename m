Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUAHThS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUAHTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:34:49 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:34691 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266085AbUAHTed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:34:33 -0500
Message-ID: <3FFDB077.8080209@colorfullife.com>
Date: Thu, 08 Jan 2004 20:33:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Paul Jackson <pj@sgi.com>, Jesper Juhl <juhl@dif.dk>, joe@perches.com,
       juhl-lkml@dif.dk, linux-kernel@vger.kernel.org,
       markhe@nextd.demon.co.uk, andrea@e-mind.com
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not
 signed - patch is against 2.6.1-rc1-mm2
References: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk> <1073531294.2304.18.camel@localhost.localdomain> <Pine.LNX.4.56.0401081032590.10083@jju_lnx.backbone.dif.dk> <20040108021658.0a8aaccc.pj@sgi.com> <20040108152822.GC8774@suse.de>
In-Reply-To: <20040108152822.GC8774@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>That's fine and has its place, no doubt about that. It doesn't cover the
>patch in this thread though. The check is dead code. It's a cosmetic
>problem though, gcc should not generate the code checking for < 0.
>  
>
I'll fix it when I touch that area again. Probably with the patch that 
allows constructors to fail, which would be 2.7 stuff. It's not really 
urgent.

--
    Manfred


