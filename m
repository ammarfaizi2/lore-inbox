Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbTCGWLn>; Fri, 7 Mar 2003 17:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261828AbTCGWLn>; Fri, 7 Mar 2003 17:11:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11788 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261826AbTCGWLl>;
	Fri, 7 Mar 2003 17:11:41 -0500
Date: Fri, 7 Mar 2003 14:12:17 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307221217.GB21315@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307123029.2bc91426.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:30:29PM -0800, Andrew Morton wrote:
> 
> 32-bit dev_t is an important (and very late!) thing to get into the 2.5
> stream.  Can we put this ahead of cleanup stuff?

Can we get people to agree that this will even go into 2.5, due to the
lateness of it?  I didn't think it was going to happen.

But if it is, a lot of character drivers need to be audited...

thanks,

greg k-h
