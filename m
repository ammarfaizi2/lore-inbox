Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJYNGX>; Thu, 25 Oct 2001 09:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJYNGQ>; Thu, 25 Oct 2001 09:06:16 -0400
Received: from [194.46.8.33] ([194.46.8.33]:15629 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S273305AbRJYNGH>;
	Thu, 25 Oct 2001 09:06:07 -0400
Date: Thu, 25 Oct 2001 14:09:55 +0100
From: Dale Amon <amon@vnl.com>
To: Gert-Jan Rodenburg <hertog@home.nl>,
        Jonathan Morton <chromi@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defaulting new questions in scripts/Configure?
Message-ID: <20011025140955.A4942@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Gert-Jan Rodenburg <hertog@home.nl>,
	Jonathan Morton <chromi@cyberspace.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011025032741.K24348@vnl.com> <20011025105921.GNXL27467.mail2.home.nl@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011025105921.GNXL27467.mail2.home.nl@there>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 12:59:22PM +0200, Gert-Jan Rodenburg wrote:
> On Thursday 25 October 2001 04:27, Dale Amon wrote:
> > I've just skimmed through the code in Configure to
> > see if there is a way to make it shut up and just
> > default everything new to NO so I can use it inside
> > a noninteractive script.
> >
> > Did I miss it or is it something that isn't there
> > to be found?
> >
> > I think I'd not be the only one to find it useful
> > to make it be seen and not heard during a
> > make oldconfig :-)
> 
> 
> no "" | make oldconfig
> 
> Not sure if it works, but in the Linux From Scratch manual they do the 
> oposite ->  yes "" | make config
> 

Jonathan Morton suggested the yes is the answer
as well. I tested both out and diffed against one
done manually. no seems to just die, yes does just
the right thing.

Thanks much to all who replied.

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
