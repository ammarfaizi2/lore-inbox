Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316324AbSEOFBe>; Wed, 15 May 2002 01:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316325AbSEOFBd>; Wed, 15 May 2002 01:01:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60157 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316324AbSEOFBd>; Wed, 15 May 2002 01:01:33 -0400
Date: Wed, 15 May 2002 01:01:07 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tony.P.Lee@nokia.com, lmb@suse.de, woody@co.intel.com,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: InfiniBand BOF @ LSM - topics of interest
Message-ID: <20020515010107.A31154@devserv.devel.redhat.com>
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A206F@mvebe001.NOE.Nokia.com> <E177od2-0000wp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 15 May 2002 03:35:00 +0100 (BST)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>

> According to folks at Quantum the IB stuff isnt doing 'true' congestion
> control. At the moment its hard to tell since 1.0a doesn't deal with
> congestion management and the 2.0 congestion stuff isnt due out until
> later this year. Even then the Infiniband trade association folks use
> words like "hopefully eliminating the congestion" in their presentation to 
> describe their mechanism.

The thing about Infiniband is that its scope is so great.
If you consider Infiniband was only a glorified PCI with serial
connector, the congestion control is not an issue. Credits
are quite sufficient to provide per link flow control, and
everything would work nicely with a couple of switches.
Such was the original plan, anyways, but somehow cluster
ninjas managed to hijack the spec and we have the rabid
overengineering running amok. In fact, they ran so far
that Intel jumped ship and created PCI Express, and we
have discussions about congestion control. Sad, really...

-- Pete
