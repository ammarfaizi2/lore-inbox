Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTATGXU>; Mon, 20 Jan 2003 01:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTATGXU>; Mon, 20 Jan 2003 01:23:20 -0500
Received: from holomorphy.com ([66.224.33.161]:4745 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261448AbTATGXT>;
	Mon, 20 Jan 2003 01:23:19 -0500
Date: Sun, 19 Jan 2003 22:32:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
Message-ID: <20030120063219.GL780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org> <20030119213524.GH780@holomorphy.com> <20030119.221013.65242960.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119.221013.65242960.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 10:10:13PM -0800, David S. Miller wrote:
> I'm totally fine with this work, in fact I consider it
> a cleanup.
> I could call it a bug fix, but that would be stretching it :-)

I'll try to maintain it, then. It's received zero runtime testing,
esp. not in true NR_CPUS > BITS_PER_LONG circumstances. But I don't
have any kind of regular (read as: once annually or less) access to
such systems, so the best I can do is chip in and attempt to keep
(largely untested/untestable) patches current.

This looks like it diverged a little bit from rusty's implementation,
partly because I thought it'd be easier to just pound things out from
scratch as opposed to attempting to port directly.

rusty, if you could comment on the differences, I'd be much obliged.

I'll also attempt to get a SPARC toolchain together (as I understand it,
there are some divergences from mainline/current gcc/binutils) and do
some compiletesting-like and API conversion things there.

Thanks,
Bill
