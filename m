Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277591AbRJVS6t>; Mon, 22 Oct 2001 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277665AbRJVS6k>; Mon, 22 Oct 2001 14:58:40 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:57609 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S277655AbRJVS6e>; Mon, 22 Oct 2001 14:58:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Fedyk <mfedyk@matchmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VM
Date: Mon, 22 Oct 2001 20:59:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Michael T. Babcock" <mbabcock@fibrespeed.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BD420ED.4090508@fibrespeed.net> <E15vffF-00023N-00@the-village.bc.nu> <20011022110058.C27227@mikef-linux.matchmail.com>
In-Reply-To: <20011022110058.C27227@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011022185859Z16022-4006+539@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 22, 2001 08:00 pm, Mike Fedyk wrote:
> On Mon, Oct 22, 2001 at 03:02:49PM +0100, Alan Cox wrote:
> > > I have never done this comparison myself, but I was wondering how ugly 
> > > it would be if stable versions of Andrea's and Rik's VMs were both 
> > > available in your/Linus' kernel as compile-time options.  Assuming that 
> > > each provides better performance under certain conditions, wouldn't 
> > 
> > Too ugly for words.
> 
> Though, if it's done from the start of 2.5, it could be very possible.  Is
> there a way to make it non-ugly?

No, not within the current structure of our config system.  It touches the 
tree in many places break out nicely into a few defines or separable files. 
Both mm variants are under heavy development and injecting them with a bunch 
of cruft just to make it compile-time configurable would only add to the 
difficulty of maintaining a subsystem that already is very difficult to 
maintain.

This is properly a patch.

If you want to argue for something, argue for giving config the ability to 
apply patches, that would be lots of fun.

--
Daniel
