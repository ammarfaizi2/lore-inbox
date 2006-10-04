Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWJDWl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWJDWl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWJDWl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:41:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48910 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751199AbWJDWl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:41:56 -0400
Date: Thu, 5 Oct 2006 00:41:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
Message-ID: <20061004224154.GC16812@stusta.de>
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain> <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:02:36AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 2 Oct 2006, Alan Cox wrote:
> >
> > Ar Llu, 2006-10-02 am 09:40 -0700, ysgrifennodd Linus Torvalds:
> > > If you want a yes/no kind of thing, do it on real hard issues, like not 
> > > accepting email from machines that aren't registered MX gateways. Sure, 
> > > that will mean that people who just set up their local sendmail thing and 
> > > connect directly to port 25 will just not be able to email, but let's face 
> > > it, that's why we have ISP's and DNS in the first place.
> > 
> > Except most of the ISPs are incompetent and many people have to run
> > their own mail system in order to get mail that actually *works*. I've
> > had that experience several times, although thankfully I now have a sane
> > ISP.
> 
> Sure. I kind of agree - I'm just saying that if you have a _hard_ 
> decision, you should base in on _hard_ data. 
>...

My personal hard data is:
- if you are sending emails to me, the fourth-last mail server in the
  path (the one that actually receives the emails from the Internet)
  does greylisting, IOW much spam that can be trivially determined is
  already eliminated when bogofilter gets the emails
- much spam I'm getting cames through lists like linux-kernel that
  have already filtered out the easy to determine spam
- despite these points, bogofilter catches 90% of the arriving spam
- one false positive every 1-2 years (sic)
- I can (and do) train bogofilter myself

It might have it's weaknesses and might therefore not work well forever,
but at least during the last years bogofilter served me well. 

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

