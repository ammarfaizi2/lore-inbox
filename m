Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbTE1MHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbTE1MHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:07:53 -0400
Received: from mail.gmx.net ([213.165.65.60]:56423 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264695AbTE1MHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:07:52 -0400
Message-ID: <3ED4A9B4.1050907@gmx.net>
Date: Wed, 28 May 2003 14:21:08 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
CC: Andrew Morton <akpm@digeo.com>, axboe@suse.de, m.c.p@wolk-project.de,
       kernel@kolivas.org, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de> <200305280930.48810.m.c.p@wolk-project.de> <20030528073544.GR845@suse.de> <20030528005156.1fda5710.akpm@digeo.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <20030528121040.GA1193@rz.uni-karlsruhe.de> <20030528121446.GB1193@rz.uni-karlsruhe.de>
In-Reply-To: <20030528121446.GB1193@rz.uni-karlsruhe.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Mueller wrote:
> On Wed, May 28, 2003 at 02:10:40PM +0200, Matthias Mueller wrote:
> 
>>Tested all of them and some combinations:
>>patch 1 alone: still mouse hangs
>>patch 2 alone: still mouse hangs
>>patch 3 alone: no hangs, but I get some zombie process (starting a lot of
>>               xterms results in zombie xterms, not noticed with vanilla
>>               and the other patches)
>>patch 1+2: no mouse hangs
>>patch 1+2+3: no mouse hangs, no zombies
> 
> 
> Forgot to mention: no zombies with patch 1 or 2

So 1+2 gives you zombies?


Carl-Daniel

