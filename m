Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWBVQqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWBVQqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWBVQqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:46:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030180AbWBVQqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:46:52 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: David Zeuthen <david@fubar.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
In-Reply-To: <20060222163511.GA18694@infradead.org>
References: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
	 <20060221225718.GA12480@vrfy.org>
	 <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
	 <20060222152743.GA22281@vrfy.org>
	 <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
	 <1140625103.21517.18.camel@daxter.boston.redhat.com>
	 <20060222163511.GA18694@infradead.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 11:46:01 -0500
Message-Id: <1140626762.21517.24.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 16:35 +0000, Christoph Hellwig wrote:
> On Wed, Feb 22, 2006 at 11:18:22AM -0500, David Zeuthen wrote:
> > For just one example of API breaking see
> > 
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175998
> > 
> > This breaks stuff for end users in a stable distribution. Not good.
> 
> That's not an API breakage.  The API is left untouched, the driver
> now just reports the attached device as what it is.

ABI then, whatever..

>   If HAL wasn't
> a piece of cargo-cult programming crap 

We love you too Christoph.

> you'd see in the relevant
> standards what scsi device types exist, or even better stop relying
> on such low-level knowledge.  

Then don't export it unless it's useful. You did break ABI, don't try to
make up stupid excuses.

> It's a disk if sd_mod attaches to it
> is a much better rule than relying on lowlevel SAM details.

That's another way to do it.

    David


