Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSGIKvc>; Tue, 9 Jul 2002 06:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSGIKvb>; Tue, 9 Jul 2002 06:51:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15041 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313537AbSGIKv2>;
	Tue, 9 Jul 2002 06:51:28 -0400
Date: Tue, 9 Jul 2002 12:53:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020709105352.GC20870@suse.de>
References: <20020709102249.GA20870@suse.de> <Pine.SOL.3.96.1020709114618.20865B-100000@libra.cus.cam.ac.uk> <20020709104935.GB20870@suse.de> <20020709125135.A7885@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020709125135.A7885@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Vojtech Pavlik wrote:
> On Tue, Jul 09, 2002 at 12:49:35PM +0200, Jens Axboe wrote:
> 
> > On Tue, Jul 09 2002, Anton Altaparmakov wrote:
> > > On Tue, 9 Jul 2002, Jens Axboe wrote:
> > > > I've forward ported the 2.4 IDE core (well 2.4.19-pre10-ac2 to be exact)
> > > > to 2.5.25. It consists of 7 separate patches:
> > > 
> > > Fantastic! Seeing that the patches are bitkeeper generated, would it be
> > > possible for you to make a repository available with the patches? (on
> > > bkbits perhaps?) Would make it a lot easier for us bitkeeper users just to
> > > pull from your repository... Especially once you update the patches...
> > 
> > Yes they are from a bk tree here, I'll set one up on bkbits...
> 
> Cool, thanks. I guess I also will make a lot of use of those patches.
> I need to be debugging input now, not IDE. ;) 

Let me add that I've only tested on x86 right now, other archs should
"just work" with a few changes to include/asm/ide.h (see the changes in
15_24-misc-bits-1).

Enjoy :-)

-- 
Jens Axboe

