Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWAZFLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWAZFLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZFLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:11:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34222 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751298AbWAZFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:11:47 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Lee Revell <rlrevell@joe-job.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060126050147.GB23296@mail.shareable.org>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
	 <1138181033.4800.4.camel@tara.firmix.at>
	 <20060125150516.GB8490@mail.shareable.org>
	 <1138231714.3087.66.camel@mindpipe>
	 <20060126050147.GB23296@mail.shareable.org>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 00:11:46 -0500
Message-Id: <1138252307.3087.110.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 05:01 +0000, Jamie Lokier wrote:
> Lee Revell wrote:
> > > Mozilla / Firefox / Opera in particular.  300MB is not funny on a
> > > laptop which cannot be expanded beyond 192MB.  Are there any usable
> > > graphical _small_ web browsers around?  Usable meaning actually works
> > > on real web sites with fancy features.
> > 
> > "Small" and "fancy features" are not compatible.
> > 
> > That's the problem with the term "usable" - to developers it means
> > "supports the basic core functionality of a web browser" while to users
> > it means "supports every bell and whistle that I get on Windows".
> 
> As both a developer and user, all I want is a web browser that works
> with the sites I visit, and performs reasonably well on my laptop.
> 
> I know there are fast algorithms for layout, for running scripts and
> updating trees, and the memory usage doesn't have to be anywhere near
> as much as it is.
> 
> So it's reasonable to ask if anyone has written a fast browser that
> works with current popular sites in fits in under 256MB after a few
> days use.
> 
> Unfortunately, the response seems to be no, nobody has.  I guess it's
> a big job and there isn't the interest and resourcing to do it.
> 

What's wrong with Firefox?

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rlrevell  6423  6.7 16.7 167676 73804 ?        Sl   Jan25  79:41 /usr/lib/firefox/firefox-bin -a firefox

73MB is not bad.

Obviously if you open 20 tabs, it will take a lot more memory, as it's
going to have to cache all the rendered pages.

Lee

