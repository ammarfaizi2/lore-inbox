Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318220AbSGPVMU>; Tue, 16 Jul 2002 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSGPVMT>; Tue, 16 Jul 2002 17:12:19 -0400
Received: from holomorphy.com ([66.224.33.161]:24196 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318220AbSGPVMS>;
	Tue, 16 Jul 2002 17:12:18 -0400
Date: Tue, 16 Jul 2002 14:14:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Jens Axboe <axboe@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716211455.GE1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jari Ruusu <jari.ruusu@pp.inet.fi>, Jens Axboe <axboe@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva> <20020716170921.GX811@suse.de> <3D34773C.F61E7C0F@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D34773C.F61E7C0F@pp.inet.fi>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 10:42:52PM +0300, Jari Ruusu wrote:
> The patch below fixes that remap issue, plus uncounted number of other loop
> issues. For example, device backed loops use pre-allocated pages for zero VM
> pressure.

I'd like to understand this (and possibly even use it) as I tend to use
the loopback block driver often. Any chance you could break this up into
a blow-by-blow series of bugfixes? As it is here, it's a bit much for me
to digest as a newbie to bio.

My needs for explanation are perhaps greater than others on the cc: list,
so it's really optional, but I'd be much obliged if you could do so.


Thanks,
Bill
