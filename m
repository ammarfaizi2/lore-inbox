Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRJBJ42>; Tue, 2 Oct 2001 05:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275999AbRJBJ4N>; Tue, 2 Oct 2001 05:56:13 -0400
Received: from mail.zmailer.org ([194.252.70.162]:30220 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S275994AbRJBJzr>;
	Tue, 2 Oct 2001 05:55:47 -0400
Date: Tue, 2 Oct 2001 12:56:14 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
Message-ID: <20011002125614.M1144@mea-ext.zmailer.org>
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> <20010926004345.D11046@mea-ext.zmailer.org> <20010927142251.A58@toy.ucw.cz> <20011002112921.A7117@suse.cz> <20011002114801.A19015@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002114801.A19015@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Tue, Oct 02, 2001 at 11:48:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 11:48:01AM +0200, Pavel Machek wrote:
> > > > 	Also, generic PROMISC mode still drops off received frames
> > > > 	with CRC error.
> > > 
> > > Hmm, sounds good. Someone should create tool for communication over
> > > ethernet with broken crc's. Such communication would be stealth from
> > > normal tcpdump. Do it on your provider's network to escape accounting ;^)
> > 
> > But still you'll see the number of errors on your eth card
> > skyrocketing, so you'd grow quite suspicious. 
> 
> Yep, but it would be _very_ hard for you to find the cause. You'd
> probably chase ghosts trying to replace cables, etc, never finding
> what happens.

	This kind of use will need its own network driver, which
	will count errors differently, of course.

> 							Pavel

/Matti Aarnio
