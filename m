Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbTCHVbF>; Sat, 8 Mar 2003 16:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTCHVbF>; Sat, 8 Mar 2003 16:31:05 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:41160 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S262219AbTCHVbD>; Sat, 8 Mar 2003 16:31:03 -0500
Date: Sat, 8 Mar 2003 13:41:30 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308214130.GK2835@ca-server1.us.oracle.com>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308194331.A31291@infradead.org>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 07:43:31PM +0000, Christoph Hellwig wrote:
> So people should have started working on it sooner.  If people really think
> they need a 32bit dev_t for their $BIGNUM of disks (and I still don't buy
> that argument) we should just introduce it and use it only for block devices
> (which already are fixed up for this) and stay with the old 8+8 split for
> character devices.  Note that Linux is about doing stuff right, not fast.

	Wait, so ugly hacks that steal every remaining major is doing it
'right'?  I've done the math with the current available majors.  I don't
see 4000 disks there, and that is just life as it exists today, not 2-3
years from now when 2.8 finally appears.  Like Andrew asked, please
describe exactly how you'd support it.

Joel


-- 

"Behind every successful man there's a lot of unsuccessful years."
        - Bob Brown

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
