Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131966AbRCVKo7>; Thu, 22 Mar 2001 05:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131982AbRCVKou>; Thu, 22 Mar 2001 05:44:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:17102 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131966AbRCVKoi>;
	Thu, 22 Mar 2001 05:44:38 -0500
Message-ID: <3AB9D628.5B01E8B@mandrakesoft.com>
Date: Thu, 22 Mar 2001 05:38:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tomasz Sterna <smoku@jaszczur.org>
Cc: James Simmons <jsimmons@linux-fbdev.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: standard_io_resources[]
In-Reply-To: <Pine.LNX.4.31.0103210908560.2648-100000@linux.local> <20010322094159.A7407@plwawtl0.pl.ccbeverages.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Sterna wrote:
> 
> On Wed, Mar 21, 2001 at 09:13:05AM -0800, James Simmons wrote:
> > >Isn't that a job of the device drivers?
> > Well most of those resources are present on every PC motherboard.
> 
> I still can't see a reason for allocating it before the device drivers
> could do that.
> 
> Any suggestions? Anyone?

If you write into those resources and they are absent, bad things
sometimes happen.  So, they are always added to the reserved-resource
list.  I already had this argument with Linus :)

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
