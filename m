Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbTBQKZ6>; Mon, 17 Feb 2003 05:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTBQKZ5>; Mon, 17 Feb 2003 05:25:57 -0500
Received: from mail.zmailer.org ([62.240.94.4]:6555 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266967AbTBQKZ5>;
	Mon, 17 Feb 2003 05:25:57 -0500
Date: Mon, 17 Feb 2003 12:35:53 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Mark J Roberts <mjr@znex.org>, linux-kernel@vger.kernel.org
Subject: Re: Annoying /proc/net/dev rollovers.
Message-ID: <20030217103553.GH1073@mea-ext.zmailer.org>
References: <20030216221616.GA246@znex> <20030217014111.GA2244@f00f.org> <20030217024605.GB246@znex> <20030217042156.GA2759@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217042156.GA2759@f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 08:21:56PM -0800, Chris Wedgwood wrote:
> On Sun, Feb 16, 2003 at 08:46:05PM -0600, Mark J Roberts wrote:
> > When the windows box behind my NAT is using all of my 640kbit/sec
> > downstream to download movies, it takes a little over 14 hours to
> > download four gigabytes and roll over the byte counter.
> 
> Therefore userspace needs to check the counters more often... say ever
> 30s or so and detect rollover.  Most of this could be simply
> encapsulated in a library and made transparent to the upper layers.

  Some of my colleques complained once, that at full tilt
  the fiber-channel fabric overflowed its SNMP bitcounters
  every 2 seconds.

  "we need to do polling more rapidly, than the poller can do"

  The SNMP pollers do handle gracefully 32-bit unsigned overlow,
  they just need to get snapshots in increments a bit under 2G...
  (Hmm.. perhaps I remember that wrong, a bit under 4G should be ok.)

>   --cw

/Matti Aarnio
