Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJAQ4y>; Tue, 1 Oct 2002 12:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJAQ4q>; Tue, 1 Oct 2002 12:56:46 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:62607 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262125AbSJAQ4S>;
	Tue, 1 Oct 2002 12:56:18 -0400
Date: Tue, 1 Oct 2002 19:01:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: CPU/cache detection wrong
Message-ID: <20021001190130.A13811@ucw.cz>
References: <m3hegaxpp0.fsf@lapper.ihatent.com> <1033403655.16933.20.camel@irongate.swansea.linux.org.uk> <m3wup3bcgb.fsf@lapper.ihatent.com> <20020930221536.GA6987@suse.de> <m3smzqipzd.fsf@lapper.ihatent.com> <20021001110628.GA17865@suse.de> <m3d6qu41ms.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3d6qu41ms.fsf@lapper.ihatent.com>; from alexh@ihatent.com on Tue, Oct 01, 2002 at 05:31:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 05:31:07PM +0200, Alexander Hoogerhuis wrote:
> Dave Jones <davej@codemonkey.org.uk> writes:
> 
> > On Tue, Oct 01, 2002 at 09:21:26AM +0200, Alexander Hoogerhuis wrote:
> >  > Here we go:
> >  > 
> >  > CPU: Trace cache: 12K uops, L1 D cache: 8K
> >  > CPU: L2 cache: 512K
> >  > 
> >  > But my BIOS still say I should have 8Kb/8Kb I/D L1 cache... oh
> >  > well. I'm sure Alan Cox would just write it up as marketing, since
> >  > thats about how reliable a BIOS is :)
> > 
> > Hmm, can a P4 have a trace cache AND an L1 I cache ?
> > I thought they were exclusive, which is why the code
> > doesn't take this into account. Easily fixed if so though..
> > 
> 
> I don't know the gory details of it, but my BIOS claims I got 8/8, but
> I'm deep enough in it now to start taking the 5th amendment on the
> details here :)

12k of trace cache and 8k of I-cache are more or less equivalent - trace
cache is less effective because it has decoded uops, while i-cache has
encoded instructions, which take up less space.

-- 
Vojtech Pavlik
SuSE Labs
