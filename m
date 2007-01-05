Return-Path: <linux-kernel-owner+w=401wt.eu-S1161050AbXAEKqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbXAEKqH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbXAEKqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:46:07 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:32812 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161050AbXAEKqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:46:05 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 5 Jan 2007 05:41:05 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: "Ahmed S. Darwish" <darwish.07@gmail.com>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
In-Reply-To: <20070105105113.120d72c9@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701050540470.23540@localhost.localdomain>
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de>
 <20070105100610.GA382@Ahmed> <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
 <20070105105113.120d72c9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Alan wrote:

> > represents a kmalloc->kzalloc cleanup (there's lots of those), and
> > also see if you can replace one of these:
> >
> >   sizeof(struct blah)
> >
> > with one of these:
> >
> >   sizeof(*blahptr)
>
> Patches that do this will get rejected by the tty maintainer in favour of
> the clarity of the sizeof(struct xyz) format 8)

ok, i was just going by the recommendations of the CodingStyle guide.

rday
