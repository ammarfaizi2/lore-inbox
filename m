Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbTCHBDN>; Fri, 7 Mar 2003 20:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbTCHBDM>; Fri, 7 Mar 2003 20:03:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42252 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261789AbTCHBDL>;
	Fri, 7 Mar 2003 20:03:11 -0500
Date: Fri, 7 Mar 2003 17:03:46 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: alan@lxorguk.ukuu.org.uk, hch@infradead.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308010346.GH23071@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com> <1047086062.24215.14.camel@irongate.swansea.linux.org.uk> <20030308005018.GE23071@kroah.com> <20030307170520.5e38c3c9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307170520.5e38c3c9.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 05:05:20PM -0800, Andrew Morton wrote:
> 
> Some time back Linus expressed a preference for a 2^20 major / 2^12 minor split.

I remember that too. That's still increasing the number of minors, hence
my original reservation about auditing drivers.

thanks,

greg k-h
