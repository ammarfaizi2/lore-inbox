Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbSJLEFa>; Sat, 12 Oct 2002 00:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSJLEFa>; Sat, 12 Oct 2002 00:05:30 -0400
Received: from dp.samba.org ([66.70.73.150]:18657 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262802AbSJLEF3>;
	Sat, 12 Oct 2002 00:05:29 -0400
Date: Sat, 12 Oct 2002 14:09:59 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021012040959.GE7050@krispykreme>
References: <3DA798B6.9070400@us.ibm.com> <20021012035141.GC7050@krispykreme> <20021012035958.GD10722@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012035958.GD10722@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Bah! I'm at a competitive disadvantage because I've got a lesser
> BITS_PER_LONG. No matter, NR_CPUS > BITS_PER_LONG shall be conquered
> and the explosion of kernel threads will be quite visible (though
> unfortunately probably post-freeze).

Speaking of which, the recent CONFIG_NR_CPUS addition shows just how
bloated all our [NR_CPU] structures are. We need to get serious about
using the per cpu data stuff. Going from 32 to 64 was over 500kB on my
ppc64 build.

Anton
