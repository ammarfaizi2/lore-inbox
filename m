Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTGRQTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271856AbTGRQSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:18:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3083 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271869AbTGRQRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:17:42 -0400
Date: Fri, 18 Jul 2003 12:25:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test1-ac2
In-Reply-To: <20030716233359.GE7263@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1030717184137.17023C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, J.A. Magallon wrote:

> 
> On 07.16, Alan Cox wrote:
> > On Mer, 2003-07-16 at 21:13, Michael Kristensen wrote:
> > > Apropos emu10k1. Why is OSS deprecated? I have tried a little to get
> > > ALSA working, but it doesn't seem to work. Hint?
> > 
> > ALSA has a lot more functionality than OSS and the API is better in many
> > ways. The ALSA drivers dont have so much use and exposure so they will
> > need time to shake down, but it should be worth it in the end.
> > 
> 
> What I do not understand is why alsa has not gone into 2.4.
> This will smooth transition to 2.6. Same as i2c. People starts using
> alsa, then they switch to 2.6 and everything works.

I would assume that it's time to stop backporting stuff to 2.4, leave it
stable and let the new cacpabilities entice people to move to 2.6.

I've had enough learning experiences with ALSA to convince me that both
the code and the documentation have a few rough edges. I'd love to just be
able to use sound hardware instead of fighting every system trying get the
options right, find and download the right tools and software versions,
recompile this and that... 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

