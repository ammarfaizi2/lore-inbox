Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbREULyy>; Mon, 21 May 2001 07:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbREULyp>; Mon, 21 May 2001 07:54:45 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15367 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261398AbREULya>; Mon, 21 May 2001 07:54:30 -0400
Date: Mon, 21 May 2001 15:51:51 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521155151.A10403@jurassic.park.msu.ru>
In-Reply-To: <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521131959.M30738@athlon.random>; from andrea@suse.de on Mon, May 21, 2001 at 01:19:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 01:19:59PM +0200, Andrea Arcangeli wrote:
> Alpha in mainline is just screwedup if a single pci bus tries to dynamic
> map more than 128mbyte, changing it to 512mbyte is trivial, growing more

Could you just describe the configuration where increasing sg window
from 128 to 512Mb actually fixes "out of ptes" problem? I mean which
drivers involved, what kind of load etc.
I'm unable reproduce it with *8Mb* window, so I'm asking.

Ivan.
