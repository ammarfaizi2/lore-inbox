Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274162AbRJTT4Z>; Sat, 20 Oct 2001 15:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274194AbRJTT4P>; Sat, 20 Oct 2001 15:56:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11768
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274162AbRJTT4B>; Sat, 20 Oct 2001 15:56:01 -0400
Date: Sat, 20 Oct 2001 12:56:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Message-ID: <20011020125629.A31863@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"M. Edward Borasky" <znmeb@aracnet.com>,
	"Linux-Kernel@Vger.  Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com> <20011020003812Z16243-4005+727@humbolt.nl.linux.org> <1003539951.939.3.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1003539951.939.3.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 09:05:29PM -0400, Robert Love wrote:
> On Fri, 2001-10-19 at 20:38, Daniel Phillips wrote:
> > Keep in mind that once you start exposing tuning parameters you tend to get 
> > lots of user programs out there that break without the parameters, or if the 
> > parameters don't behave the same way across versions.  Official tuning 
> > parameters also get in the way of trying out new algorithms, which might not 
> > even support the old tweaks, for example.
> 
> Agreed.  They also encourage people to write algorithms that are
> suboptimal, but perform OK with proper tuning.  This, imho, is the
> biggest argument against.
> 

How does this differ when the tuning is hard coded?

There are always cases where the algo will fall over.

One thing I can say in favor of hard coded tuning is that it encourages the
cases where it does fall over to be reported, and possibly fixed.
