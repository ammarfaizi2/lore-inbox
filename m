Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbREVUkr>; Tue, 22 May 2001 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262801AbREVUkh>; Tue, 22 May 2001 16:40:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12449 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262800AbREVUk3>;
	Tue, 22 May 2001 16:40:29 -0400
Message-ID: <3B0ACEB1.F3806F00@mandrakesoft.com>
Date: Tue, 22 May 2001 16:40:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
In-Reply-To: <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522170016.D15155@athlon.random> <20010522132815.A4573@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> 
> On Tue, May 22, 2001 at 05:00:16PM +0200, Andrea Arcangeli wrote:
> > I'm also wondering if ISA needs the sg to start on a 64k boundary,
> 
> Traditionally, ISA could not do DMA across a 64k boundary.
> 
> The only ISA card I have (a soundblaster compatible) appears
> to work without caring for this, but I suppose we should pay
> lip service to pedantics.

ISA cards can do sg?

[sure it's theoretically possible... do any drivers use it though, if
such hardware even exists?]

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
