Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313762AbSD2RmT>; Mon, 29 Apr 2002 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSD2RmT>; Mon, 29 Apr 2002 13:42:19 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:61932 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S313762AbSD2RmS>; Mon, 29 Apr 2002 13:42:18 -0400
Date: Mon, 29 Apr 2002 19:41:34 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Ian Molton <spyro@armlinux.org>
cc: tomas szepe <kala@pinerecords.com>, alchemy@us.ibm.com, rml@tech9.net,
        alan@lxorguk.ukuu.org.uk, rthrapp@sbcglobal.net,
        linux-kernel@vger.kernel.org
Subject: Re: The tainted message
In-Reply-To: <20020429184331.3230f5ab.spyro@armlinux.org>
Message-ID: <Pine.GSO.4.05.10204291939240.21793-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002, Ian Molton wrote:

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

well, that's not the truth: the kernel itself is debuggable, but we don't
	know about the module, and how the module interacts with the
	kernel.

why not simply state that "the source to this module doesn't seem to be
available..." ? 

	tm
-- 
in some way i do, and in some way i don't.

