Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289769AbSBNF3i>; Thu, 14 Feb 2002 00:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289762AbSBNF3T>; Thu, 14 Feb 2002 00:29:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47883 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289750AbSBNF3L>;
	Thu, 14 Feb 2002 00:29:11 -0500
Message-ID: <3C6B4B20.FE4AE960@mandrakesoft.com>
Date: Thu, 14 Feb 2002 00:29:04 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Petro <petro@auctionwatch.com>, linux-kernel@vger.kernel.org
Subject: Re: Eepro100 driver.
In-Reply-To: <20020213211639.GB2742@auctionwatch.com> <3C6B2277.CA9A0BF8@mandrakesoft.com> <3C6B406E.1010706@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Jeff Garzik wrote:
> 
> > Long term, it is going to be replaced with e100 from Intel, as soon as
> > that driver is in good shape.
> 
> Any ETA on that?  (Make them really support the ethtool IOCTLs first :))

Soon but not terribly soon.  Intel has been responsive to feedback from
Andrew Morton and myself.  Once it passes our review and Intel's
testing, it will go in.  eepro100 will live on for a while, until we are
certain e100 is stable, though.  (and eepro100 won't disappear from 2.4
at all)


> In the past, I heard there were licensing problems, have those
> been cleared up?

Things are looking hopeful on this front.  e1000 is going to be
submitted for inclusion into the kernel soon, reportedly with a GPL /
BSD + patent grant license.  e100 should follow suit.

This hasn't happened yet, so I don't want to say "yes" for sure...

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
