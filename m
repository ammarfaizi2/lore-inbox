Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262153AbTCHTll>; Sat, 8 Mar 2003 14:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbTCHTlS>; Sat, 8 Mar 2003 14:41:18 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:20236 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262153AbTCHTjz>; Sat, 8 Mar 2003 14:39:55 -0500
Date: Sat, 8 Mar 2003 19:50:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308195028.A31394@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@digeo.com>, Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com> <1047086062.24215.14.camel@irongate.swansea.linux.org.uk> <20030308005018.GE23071@kroah.com> <1047136302.25932.28.camel@irongate.swansea.linux.org.uk> <20030308193722.GD26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308193722.GD26374@kroah.com>; from greg@kroah.com on Sat, Mar 08, 2003 at 11:37:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 11:37:22AM -0800, Greg KH wrote:
> That's a good start, but why not change that to a simple,
> HOW_MANY_MINORS_I_WANT, which will work the same way now, but allow us
> to change to a pure dynamic major/minor allocation scheme in the future
> by only modifying the register_chr_device() code.  Same thing for
> register_blkdev().

register_blkdev() _IS_ totally meaningless in 2.5.  I said this about three
times in this thread already, when will people actually take a look at
the code they look at?

