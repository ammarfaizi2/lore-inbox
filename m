Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279412AbRKIF7Y>; Fri, 9 Nov 2001 00:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279416AbRKIF7O>; Fri, 9 Nov 2001 00:59:14 -0500
Received: from ns.suse.de ([213.95.15.193]:40970 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279412AbRKIF7F>;
	Fri, 9 Nov 2001 00:59:05 -0500
Date: Fri, 9 Nov 2001 06:59:04 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109065904.A14557@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <p731yj8kgvw.fsf@amdsim2.suse.de> <20011109141215.08d33c96.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011109141215.08d33c96.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Fri, Nov 09, 2001 at 02:12:15PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 02:12:15PM +1100, Rusty Russell wrote:
> Modules have lots of little disadvantages that add up.  The speed penalty
> on various platforms is one, the load/unload race complexity is another.

At least for the speed penalty due to TLB thrashing: I would not really
blame modules in this case, it is just an application crying for large
pages support.

-Andi
