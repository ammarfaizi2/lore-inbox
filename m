Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262819AbREVU6R>; Tue, 22 May 2001 16:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbREVU6H>; Tue, 22 May 2001 16:58:07 -0400
Received: from are.twiddle.net ([64.81.246.98]:31873 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262818AbREVU5z>;
	Tue, 22 May 2001 16:57:55 -0400
Date: Tue, 22 May 2001 13:57:42 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522135742.A4662@twiddle.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
In-Reply-To: <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522170016.D15155@athlon.random> <20010522132815.A4573@twiddle.net> <3B0ACEB1.F3806F00@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0ACEB1.F3806F00@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 22, 2001 at 04:40:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 04:40:17PM -0400, Jeff Garzik wrote:
> ISA cards can do sg?

No, but the host iommu can.  The isa card sees whatever
view of memory presented to it by the iommu.


r~
