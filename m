Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTFLCja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFLCja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:39:30 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:40196 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264701AbTFLCjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:39:23 -0400
Message-ID: <3EE7EAF1.3080400@cyberone.com.au>
Date: Thu, 12 Jun 2003 12:52:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <1055296630.23697.195.camel@tiny.suse.com> <20030611021030.GQ26270@dualathlon.random> <1055353360.23697.235.camel@tiny.suse.com> <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <3EE7EA4A.5030105@cyberone.com.au> <3EE7EAB2.5010705@cyberone.com.au>
In-Reply-To: <3EE7EAB2.5010705@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> I guess you could fix this by having a "last woken" flag, and
> allow that process to allocate requests without blocking from
> the batch limit until the queue full limit. That is how
> batch_requests is supposed to work.


s/flag/pid maybe?

