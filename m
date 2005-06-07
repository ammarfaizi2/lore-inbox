Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVFGV1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVFGV1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVFGV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:27:18 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:63384 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261989AbVFGV1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:27:09 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: oops 2.6.11 and 2.6.12-rc6
From: Alexander Nyberg <alexn@telia.com>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050607194852.GA3638@the-penguin.otak.com>
References: <20050607182329.GA3950@the-penguin.otak.com>
	 <1118172809.956.6.camel@localhost.localdomain>
	 <20050607194852.GA3638@the-penguin.otak.com>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 23:27:06 +0200
Message-Id: <1118179626.956.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please always do reply-to-all around here, might get missed otherwise

> > > I have a production server that has not booted any kernel I've tried sense
> > > 2.6.10.
> > > I captured this oops by *hand* this morning when trying to boot 2.6.12-rc6.
> > > 
> > > I've included the decoded oops, lspci -vvv, .config and ver_linux information.
> > > 
> > > Unlike most cases this is a prodution machine and I have limited time to test patches. :(
> > > 
> > 
> > Unfortunately the oops text you sent cannot be used for debugging.
> > Please send the oops that 2.6.12-rc6 produces to the list (ksymoops is
> > not necessary on 2.6.x kernels and should not be used!). 
> > Depending on how early the oops happens you can definately use
> > Documentation/serial-console.txt and maybe the somewhat simpler
> > Documentation/networking/netconsole.txt
> > 
> > Please send the non-ksymoopsed oops you wrote off the screen when
> > booting 2.6.12-rc6
> > 
> > Thanks
> > 
> Here is the bare oops.
> 
> 

It appears you have disabled General setup => Configure standard kernel
=> Load all symbols

Please don't do that without a good reason, makes debugging more
difficult. How much memory is it in the box? Can you put the System.map
somewhere so I can resolve the addresses?

And you said this happened at booting right? hmmpf

