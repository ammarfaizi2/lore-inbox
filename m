Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313904AbSD2RnX>; Mon, 29 Apr 2002 13:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSD2RnW>; Mon, 29 Apr 2002 13:43:22 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:3850 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313904AbSD2RnU>; Mon, 29 Apr 2002 13:43:20 -0400
Date: Mon, 29 Apr 2002 19:42:32 +0200
From: tomas szepe <kala@pinerecords.com>
To: Ian Molton <spyro@armlinux.org>
Cc: alchemy@us.ibm.com, rml@tech9.net, alan@lxorguk.ukuu.org.uk,
        rthrapp@sbcglobal.net, linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Message-ID: <20020429174232.GA25502@louise.pinerecords.com>
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu> <1019926629.2045.698.camel@phantasy> <1020099580.5131.14.camel@w-beattie1> <20020429171516.GA25377@louise.pinerecords.com> <20020429184331.3230f5ab.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 12:22)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tomas szepe Awoke this dragon, who will now respond:
> 
> >  > Warning: The module (%s) does not seem to have a compatible license.
> >  >          Please contact the supplier of this module regarding any
> >  >          problems, or reproduce the problem after rebooting without
> >  >          ever loading this module.
> >  > 
> >  > shorter?
> > 
> >  I don't think you can strip the part about open-ness of the code --
> >  it's an essential part of the explanation. And "any problems" might
> >  be too broad.
> 
> Moreover, I think the 'compatible license thing doesnt fly.
> 
> the argument against CLOSE modules is that they make the _whole_package_
> undebuggable.
> 
> if the source is available, no matter HOW crippling its license, the
> package _IS_ debuggable.
> 
> thie warning should be:
> 
> Warning: Module %s is not open source, and as such, loading it will make
> your kernel un-debuggable. Please do not submit bug reports from a kernel
> with this module loaded, as they will be useless, and likely ignored.

Very good! I'd only change the tense to "The non-opensource module %s is
about to be loaded, which will make your kernel impossible to debug," so
that it's crystal clear that the message is not a failure notification.

T.

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
