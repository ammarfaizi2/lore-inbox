Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVBOIdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVBOIdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 03:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVBOIdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 03:33:35 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:23008 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261650AbVBOIdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 03:33:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ta3yU+ZpXEplMz2rRuP5damSAb45rmf2r6q/ZcMLi7+dxVDNArsn9QfsJTfEfACbY+10AmkQoWiKrHQ+7e7ezbQkqoOGGNUpvSgnrF47ZLHuFXkFxrbm2FHQaSzZCU/f/j+CQaUd7AJA8M/v/JpIC8f7oFnEdHv7VfCQgsjCdm0=
Message-ID: <4d8e3fd305021500333835935e@mail.gmail.com>
Date: Tue, 15 Feb 2005 09:33:31 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Cc: Roland Dreier <roland@topspin.com>, Prakash Punnoor <prakashp@arcor.de>,
       Greg KH <gregkh@suse.de>, Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1108424720.32293.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>
	 <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005 18:45:20 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-02-14 at 15:21 -0800, Roland Dreier wrote:
> >     Lee> I don't see why so much effort goes into improving boot time
> >     Lee> on the kernel side when the most obvious user space problem
> >     Lee> is ignored.
> >
> > How much of a win is it to run init scripts in parallel?  I seem to
> > recall seeing tests that show that it doesn't make much difference and
> > may even slow things down by causing more disk seeks as various things
> > start up at the same time and cause reads of different files to get
> > interleaved.
> >
> 
> This is why Windows XP reserves sapce at the beginning of the disk for
> the files read during the boot process and caches copies of them there.
> 
> But, I was referring more to things like GDM not being started until all
> the other init scripts are done.  Why not start it first, and let the
> network initialize while the user is logging in?
> 
> > On the other hand, hotplug is an area that real profiling of real
> > systems booting has identified as something that can be improved, and
> > Greg's hotplug-ng seems to be a step towards a measurable improvement.

Did anyone measure the improvement ?

-- 
Paolo <paolo dot ciarrocchi at gmail dot com>
msn: paolo407@hotmail.com
hello: ciarrop
