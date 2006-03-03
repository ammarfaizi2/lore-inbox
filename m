Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWCCUEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWCCUEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWCCUEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:04:39 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:61046 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932127AbWCCUEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:04:38 -0500
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
From: Kasper Sandberg <lkml@metanurb.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Ketrenos <jketreno@linux.intel.com>,
       NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       okir@suse.de
In-Reply-To: <20060227171029.GA763@infradead.org>
References: <43FF88E6.6020603@linux.intel.com>
	 <20060225084139.GB22109@infradead.org>
	 <1140915482.23286.6.camel@localhost.localdomain>
	 <20060227171029.GA763@infradead.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 21:04:27 +0100
Message-Id: <1141416267.17837.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 17:10 +0000, Christoph Hellwig wrote:
> On Sun, Feb 26, 2006 at 12:58:02AM +0000, Alan Cox wrote:
> > On Sad, 2006-02-25 at 08:41 +0000, Christoph Hellwig wrote:
> > > the regualatory problems are not true.  
> > 
> > They are although the binary interpretation isn't AFAIK from law but
> > from lawyers. The same is actually true in much of the EU. The actual
> > requirement is that the transmitting device must be reasonably
> > tamperproof. Some of the lawyers have decided that for a software radio
> > tamperproof means "binary".
> 
> Exactly.  There's no strong requirement, it's just over-zealous corporate
> lawyers.  That's why we need to push Intel strongly here.
i completely agree, besides, if this userspace binary blob just does
something to /sys what is to prevent a user from doing that himself?
what is to prevent someone to modify the driver slightly to smash a log
entry every time the daemon does something?

the binary userspace daemon protects against nothing.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

