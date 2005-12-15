Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVLOOmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVLOOmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVLOOmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:42:20 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:51123 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750746AbVLOOmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:42:07 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, matthew@wil.cx,
       arjan@infradead.org, torvalds@osdl.org, hch@infradead.org,
       mingo@elte.hu, pj@sgi.com, alan@lxorguk.ukuu.org.uk,
       dhowells@redhat.com, tglx@linutronix.de, Mark Lord <lkml@rtr.ca>
In-Reply-To: <20051214155432.320f2950.akpm@osdl.org>
References: <1134559121.25663.14.camel@localhost.localdomain>
	 <13820.1134558138@warthog.cambridge.redhat.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
	 <20051214155432.320f2950.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 09:41:30 -0500
Message-Id: <1134657690.13138.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 15:54 -0800, Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
> >
> > Leaving up()/down() as-is is really the most sensible option.
> >
> 
> Absolutely.
> 
> I must say that my interest in this stuff is down in
> needs-an-electron-microscope-to-locate territory.  down() and up() work
> just fine and they're small, efficient, well-debugged and well-understood. 
> We need a damn good reason for taking on tree-wide churn or incompatible
> renames or addition of risk.  What's the damn good reason here?
> 

****
> Please.  Go fix some bugs.  We're not short of them.
****

I'd give that the quote of the day!

-- Steve


