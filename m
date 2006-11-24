Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934456AbWKXHVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934456AbWKXHVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 02:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934511AbWKXHVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 02:21:13 -0500
Received: from brick.kernel.dk ([62.242.22.158]:17976 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S934456AbWKXHVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 02:21:12 -0500
Date: Fri, 24 Nov 2006 08:21:10 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Schmid <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061124072109.GY4999@kernel.dk>
References: <455DAF74.1050203@schlagmichtod.de> <20061121205124.GB4199@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121205124.GB4199@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2006, Pavel Machek wrote:
> Hi!
> 
> > Well, the actual question is the following,
> > I read about HDAPS on thinkWiki. But there is no known-to-work patch for
> > 2.6.18 and above to enable queue-freezing/harddisk parking.
> > After some googeling and digging in gamne i read that someone said that
> > there are plans for some generic support for HD-parking in the kernel
> > and thus making such patches obsolete.
> > My quesiotn just is if this is true and if there are any chances that
> > the kernel will support that soonly.
> ...
> > So i hope this issue can be adressed soon. but i also know that most of
> > you are very busy and i can not evaluate how difficult such a change
> > would be. However if anyone wants to test some things or more
> > information, i am ready. Just CC me :)
> 
> I'm afraid we need your help with development here. Porting old patch
> to 2.6.19-rc6 should be easy, and then you can start 'how do I
> makethis generic' debate.

2.6.19 will finally have the generic block layer commands, so this can
be implemented properly.

-- 
Jens Axboe

