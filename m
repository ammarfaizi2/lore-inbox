Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTBQEL6>; Sun, 16 Feb 2003 23:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBQEL6>; Sun, 16 Feb 2003 23:11:58 -0500
Received: from tapu.f00f.org ([202.49.232.129]:31629 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S266716AbTBQEL6>;
	Sun, 16 Feb 2003 23:11:58 -0500
Date: Sun, 16 Feb 2003 20:21:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Mark J Roberts <mjr@znex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying /proc/net/dev rollovers.
Message-ID: <20030217042156.GA2759@f00f.org>
References: <20030216221616.GA246@znex> <20030217014111.GA2244@f00f.org> <20030217024605.GB246@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217024605.GB246@znex>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 08:46:05PM -0600, Mark J Roberts wrote:

> When the windows box behind my NAT is using all of my 640kbit/sec
> downstream to download movies, it takes a little over 14 hours to
> download four gigabytes and roll over the byte counter.

Therefore userspace needs to check the counters more often... say ever
30s or so and detect rollover.  Most of this could be simply
encapsulated in a library and made transparent to the upper layers.



  --cw

