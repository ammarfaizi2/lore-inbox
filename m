Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284217AbRLFUki>; Thu, 6 Dec 2001 15:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284211AbRLFUja>; Thu, 6 Dec 2001 15:39:30 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:1286 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285189AbRLFUiK>; Thu, 6 Dec 2001 15:38:10 -0500
Date: Thu, 6 Dec 2001 14:07:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Lars Brinkhoff <lars.spam@nocrew.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Larry McVoy <lm@bitmover.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011206140754.A122@toy.ucw.cz>
In-Reply-To: <85elmbl4i9.fsf@junk.nocrew.org> <2455827301.1007478174@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2455827301.1007478174@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Tue, Dec 04, 2001 at 03:02:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Premise 3: it is far easier to take a bunch of operating system images 
> >    and make them share the parts they need to share (i.e., the page 
> >    cache), than to take a single image and pry it apart so that it 
> >    runs well on N processors. 
> 
> Of course it's easier. But it seems like you're left with much more work to 
> reiterate in each application you write to run on this thing. Do you want to 
> do the work once in the kernel, or repeatedly in each application? I'd say
> it's a damned sight easier to make an application work well on one big
> machine than on a cluster.

With mosix, it is exactly as hard. You just run it. I can do that today.
Larry's ideas should look same w.r.t. user.. Or maybe you'll see 128x
boot messages, but that's it.

								Pavel 
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

