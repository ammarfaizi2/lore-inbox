Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSDKOzE>; Thu, 11 Apr 2002 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314081AbSDKOzD>; Thu, 11 Apr 2002 10:55:03 -0400
Received: from www.m3.polymtl.ca ([132.207.4.60]:40455 "HELO m3.polymtl.ca")
	by vger.kernel.org with SMTP id <S314080AbSDKOzC>;
	Thu, 11 Apr 2002 10:55:02 -0400
To: Brian Beattie <alchemy@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin@m3.polymtl.ca,
        "Martin.Bligh@us.ibm.com" <J.Bligh@m3.polymtl.ca>,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>, karym@opersys.com, lmcmpou@lmc.ericsson.se,
        lmcleve@lmc.ericsson.se
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <m2it71uf4u.fsf@m3.polymtl.ca> <1018385394.7923.26.camel@w-beattie1>
From: Michel Dagenais <michel.dagenais@polymtl.ca>
Date: 11 Apr 2002 11:11:00 -0400
Message-ID: <m2ofgqtgmz.fsf@m3.polymtl.ca>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It would be easier, to fix the printk's, than to put evlogging into any
> particular piece of the kernel.

Fine, let's call evlog "an enhanced printk" and discuss the specific technical
details of the proposition.

> Evlog side-by-side with printk adds significat bloat.

Whenever you change/enhance such things you may need coexistance for a while.
However this is configurable, and to a certain extent temporary, bloat.

> > - Structured data events for which it is easier to apply filtering, querying,
> >   analysis and detection tools.
> 
> this is a post processing problem.
...
> What I hear you asking for, is to make it more of
> the kernels responsibilty easing the problem of analysing the out put,
> as opposed to making that the responsibilty of user space
> postprocessing.

Actually this is pushing the formatting out of the kernel, is more efficient,
and it leaves more flexibility to the logging daemon!
