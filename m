Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278987AbRJVWPa>; Mon, 22 Oct 2001 18:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278982AbRJVWPV>; Mon, 22 Oct 2001 18:15:21 -0400
Received: from cogito.cam.org ([198.168.100.2]:42508 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S278987AbRJVWPO>;
	Mon, 22 Oct 2001 18:15:14 -0400
From: Ed Tomlinson <tomlins@CAM.ORG>
Subject: Re: VM
To: linux-kernel@vger.kernel.org
Reply-To: tomlins@CAM.ORG
Date: Mon, 22 Oct 2001 18:10:44 -0400
In-Reply-To: <3BD420ED.4090508@fibrespeed.net> <E15vffF-00023N-00@the-village.bc.nu> <20011022110058.C27227@mikef-linux.matchmail.com> <20011022185859Z16022-4006+539@humbolt.nl.linux.org>
Organization: me
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20011022221044.B0B5D18F1A@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> On October 22, 2001 08:00 pm, Mike Fedyk wrote:
>> On Mon, Oct 22, 2001 at 03:02:49PM +0100, Alan Cox wrote:
>> > > I have never done this comparison myself, but I was wondering how
>> > > ugly it would be if stable versions of Andrea's and Rik's VMs were
>> > > both
>> > > available in your/Linus' kernel as compile-time options.  Assuming
>> > > that each provides better performance under certain conditions,
>> > > wouldn't
>> > 
>> > Too ugly for words.
>> 
>> Though, if it's done from the start of 2.5, it could be very possible. 
>> Is there a way to make it non-ugly?
> 
> No, not within the current structure of our config system.  It touches the
> tree in many places break out nicely into a few defines or separable
> files. Both mm variants are under heavy development and injecting them
> with a bunch of cruft just to make it compile-time configurable would only
> add to the difficulty of maintaining a subsystem that already is very
> difficult to maintain.
> 
> This is properly a patch.
> 
> If you want to argue for something, argue for giving config the ability to
> apply patches, that would be lots of fun.

Actually this _is_ a workable solution.  IBM has done it for decades with 
its 'VM' operating system.

You get a base file, a couple of control files, and a lists of patches.  
When you go to build a nucleus (translate kernel) the patches are applied
and the source assembled...

Ed Tomlinson

