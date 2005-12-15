Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVLOQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVLOQun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVLOQum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:50:42 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:64694 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S1750759AbVLOQum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:50:42 -0500
Message-ID: <43A19EC4.5040505@nortel.com>
Date: Thu, 15 Dec 2005 10:50:12 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, dhowells@redhat.com, pj@sgi.com, mingo@elte.hu,
       hch@infradead.org, torvalds@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134559121.25663.14.camel@localhost.localdomain>	<13820.1134558138@warthog.cambridge.redhat.com>	<20051213143147.d2a57fb3.pj@sgi.com>	<20051213094053.33284360.pj@sgi.com>	<dhowells1134431145@warthog.cambridge.redhat.com>	<20051212161944.3185a3f9.akpm@osdl.org>	<20051213075441.GB6765@elte.hu>	<20051213090219.GA27857@infradead.org>	<20051213093949.GC26097@elte.hu>	<20051213100015.GA32194@elte.hu>	<6281.1134498864@warthog.cambridge.redhat.com>	<14242.1134558772@warthog.cambridge.redhat.com>	<16315.1134563707@warthog.cambridge.redhat.com>	<1134568731.4275.4.camel@tglx.tec.linutronix.de>	<43A0AD54.6050109@rtr.ca>	<20051214155432.320f2950.akpm@osdl.org>	<17313.29296.170999.539035@gargle.gargle.HOWL>	<1134658579.12421.59.camel@localhost.localdomain> <17313.37200.728099.873988@gargle.gargle.HOWL>
In-Reply-To: <17313.37200.728099.873988@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2005 16:50:15.0311 (UTC) FILETIME=[9F6DF1F0:01C60197]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> And to convert almost all calls to down/up to mutex_{down,up}. At which
> point, it no longer makes sense to share the same data-type for
> semaphore and mutex.

If we're going to call it a mutex, it would make sense to use familiar 
terminology and call it lock/unlock rather than down/up.

Chris

