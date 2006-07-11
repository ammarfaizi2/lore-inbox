Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWGKONV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWGKONV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGKONV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:13:21 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:15280 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750822AbWGKONV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:13:21 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Mike Grundy <grundym@us.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
In-Reply-To: <20060711135430.GA5070@localhost.localdomain>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com>
	 <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com>
	 <20060623222106.GA25410@osiris.ibm.com>
	 <20060624113641.GB10403@osiris.ibm.com>
	 <1151421789.5390.65.camel@localhost>
	 <20060628055857.GA9452@osiris.boeblingen.de.ibm.com>
	 <20060707172333.GA12068@localhost.localdomain>
	 <20060707172555.GA10452@osiris.ibm.com>
	 <20060711135430.GA5070@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 11 Jul 2006 16:13:18 +0200
Message-Id: <1152627198.18034.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 09:54 -0400, Mike Grundy wrote:
> I did a little measuring. On average stop_machine_run() adds 8.7 msec of
> overhead on a 4-way config. Of that %57 was sub-msec overhead. For the times
> where overhead was measurable, the average was 20.2 msec, lowest at 10msec
> highest at 100msec. That's on a z800 under vm and I have no idea how many real
> cpus the machine has :-)

So adding 100 probes will roughly take 1 second. Not too bad, I expected it
to take longer.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


