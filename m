Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVGUUOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVGUUOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 16:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVGUUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 16:14:00 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:47811 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261868AbVGUUMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 16:12:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6Bzdwltlv55mWgSQ6s1Y+WaeFnS4knJyHfP/FfqrU9s4gsQ7nSEGKaAGOvVG1LjiP/oeA3PFFmKFDw+jtQqO7HTvCmSzoHa/+8MXMGeGuBph+gvMbH8oML1xpeDm7e7aZTXwvihz8EzDxhjlNbuDBCwejjS1Th2nSq6cOiOzC4=
Message-ID: <9a874849050721131145f5c711@mail.gmail.com>
Date: Thu, 21 Jul 2005 22:11:37 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: kernel guide to space
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Paul Jackson <pj@sgi.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux@horizon.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507211528250.12675@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714011208.22598.qmail@science.horizon.com>
	 <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
	 <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
	 <20050720174521.73c06bce.pj@sgi.com>
	 <3FC51285-941F-48B6-B5A9-1BBE95CCD816@mac.com>
	 <9a874849050721114227f3c6a7@mail.gmail.com>
	 <Pine.LNX.4.61.0507211528250.12675@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> 
> On Thu, 21 Jul 2005, Jesper Juhl wrote:
> 
> > On 7/21/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> >> On Jul 20, 2005, at 20:45:21, Paul Jackson wrote:
> > [...snip...]
> >> *cough* TargetStatistics[TargetID].HostAdapterResetsCompleted *cough*
> >>
> >> I suspect linus would be willing to accept a few cleanup patches for the
> >> BusLogic.c file.  Perhaps even one that renames BusLogic.c to buslogic.c
> >> like all the other files in the source tree, instead of using nasty
> >> StudlyCaps all over :-D
> >>
> >
> > To avoid people doing duplicate work, I just want to say that I've
> > started doing a CodingStyle/whitespace/VariableAndFunctionNaming
> > cleanup of the BusLogic driver, I'll send the patches to LKML in a few
> > hours.
> >
> Are you going to get rid of the BusLogic* in front of every variable
> and function name? (yes please??)
Yes, I am.  

>  If so, you will need a few days!

That may be, it sure turned into a bigger job than I had at first
expected. I'll break it into a few logical bits and submit them along
the way. First bits in a few hours - let's see how far I get :)


> It will take probably an hour to parse:
> struct BusLogic_FetchHostAdapterLocalRAMReguest 

Yeah, it takes time, but I'll get it done.

> 
> Thank you.
> 
np.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
