Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbRCGSzs>; Wed, 7 Mar 2001 13:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRCGSzi>; Wed, 7 Mar 2001 13:55:38 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:27144 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131161AbRCGSzV>; Wed, 7 Mar 2001 13:55:21 -0500
Message-Id: <200103071854.f27IsvO28745@aslan.scsiguy.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver 
In-Reply-To: Your message of "Wed, 07 Mar 2001 18:12:27 +0200."
             <20010307181227.H23336@mea-ext.zmailer.org> 
Date: Wed, 07 Mar 2001 11:54:57 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	I presume the aicasm (or whatever) can do its meager DB needs
>	by simpler ubiquitous things like  GDBM.   SleepyCat DBx is good,
>	but in this case as serious overkill as e.g. using Oracle ;)
>	(No, I didn't read the source of the aicasm.)

People keep saying stuff like this.  I think one of the best things
a developer can realize is that being lazy is often a good thing.  I
already was experience with using db, it took me about 5 minutes to
utilize it for this project when rolling my own would have taken
much longer, and it happens to be available on almost any platform
of interest (including windows which is used to host some of the RTOS
environments that also use this driver).  More importantly, it works...
so why fix it?

People who really want to assemble the firmware will install the required
packages.  We'll just ship precompiled firmware and make sure the dependencies
don't fire even if only a few of the files in the dependency chain are
updated.

--
Justin
