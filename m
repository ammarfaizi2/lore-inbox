Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVLORKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVLORKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLORKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:10:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:21427 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750776AbVLORKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:10:17 -0500
Date: Thu, 15 Dec 2005 09:09:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, nikita@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, tglx@linutronix.de, mingo@elte.hu, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051215090951.9276697c.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0512150817170.3292@g5.osdl.org>
References: <17313.37200.728099.873988@gargle.gargle.HOWL>
	<1134559121.25663.14.camel@localhost.localdomain>
	<13820.1134558138@warthog.cambridge.redhat.com>
	<20051213143147.d2a57fb3.pj@sgi.com>
	<20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
	<14242.1134558772@warthog.cambridge.redhat.com>
	<16315.1134563707@warthog.cambridge.redhat.com>
	<1134568731.4275.4.camel@tglx.tec.linutronix.de>
	<43A0AD54.6050109@rtr.ca>
	<20051214155432.320f2950.akpm@osdl.org>
	<17313.29296.170999.539035@gargle.gargle.HOWL>
	<1134658579.12421.59.camel@localhost.localdomain>
	<4743.1134662116@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0512150817170.3292@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> Hint: we have DECLARE_MUTEX exactly because it's also DOCUMENTATION that 
> we use a semaphore as a pure binary mutex. Not because we need it.

That's insane ... 

This is stealth documentation at its finest.  Who besides Linus even
knew that's what this spelling of the DECLARE macro was telling us?

  Paul "Hand me that chain saw, Billy Jo.  This limb is coming -down-" Jackson

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
