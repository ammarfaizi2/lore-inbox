Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbREVU25>; Tue, 22 May 2001 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbREVU2r>; Tue, 22 May 2001 16:28:47 -0400
Received: from are.twiddle.net ([64.81.246.98]:27777 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262798AbREVU2e>;
	Tue, 22 May 2001 16:28:34 -0400
Date: Tue, 22 May 2001 13:28:15 -0700
From: Richard Henderson <rth@twiddle.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522132815.A4573@twiddle.net>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
In-Reply-To: <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522170016.D15155@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010522170016.D15155@athlon.random>; from andrea@suse.de on Tue, May 22, 2001 at 05:00:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 05:00:16PM +0200, Andrea Arcangeli wrote:
> I'm also wondering if ISA needs the sg to start on a 64k boundary,

Traditionally, ISA could not do DMA across a 64k boundary.

The only ISA card I have (a soundblaster compatible) appears
to work without caring for this, but I suppose we should pay
lip service to pedantics.


r~
