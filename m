Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262842AbSJASKW>; Tue, 1 Oct 2002 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbSJASKW>; Tue, 1 Oct 2002 14:10:22 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:61852 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262842AbSJASKV>;
	Tue, 1 Oct 2002 14:10:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.4 mm trouble [possible lru race]
Date: Tue, 1 Oct 2002 20:14:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
       Richard.Zidlicky@stud.informatik.uni-erlangen.de, zippel@linux-m68k.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva> <E17wRKZ-0005vf-00@starship> <20021001180442.GI5755@suse.de>
In-Reply-To: <20021001180442.GI5755@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wRXo-0005vk-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 20:04, Jens Axboe wrote:
> On Tue, Oct 01 2002, Daniel Phillips wrote:
> > On Tuesday 01 October 2002 19:31, Jens Axboe wrote:
> > > Again, m68k was the target.
> > 
> > Sure fine, no good reason to be cryptic about it though.
> > 
> >    #error "m68k doesn't do SMP yet"
> > 
> > So SMP must be off or the compile would abort.  Well, the only interesting
> 
> There's no CONFIG_SMP in the m68k arch config.in. Anyways, enough
> beating of dead horse :)

The horse isn't dead yet, it's still twitching a little.  At this
point we still need to speculate about wny anyone would want an SMP
Dragonball machine ;-)

-- 
Daniel
