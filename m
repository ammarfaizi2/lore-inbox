Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbRBAGb5>; Thu, 1 Feb 2001 01:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBAGbh>; Thu, 1 Feb 2001 01:31:37 -0500
Received: from styx.suse.cz ([195.70.145.226]:18423 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129044AbRBAGbc>;
	Thu, 1 Feb 2001 01:31:32 -0500
Date: Thu, 1 Feb 2001 07:31:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: safemode <safemode@voicenet.com>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Raufeisen <david@fortyoz.org>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010201073126.A285@suse.cz>
In-Reply-To: <E14O60w-0003IO-00@the-village.bc.nu> <3A789869.B05506FB@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A789869.B05506FB@voicenet.com>; from safemode@voicenet.com on Wed, Jan 31, 2001 at 05:57:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 05:57:45PM -0500, safemode wrote:
> Alan Cox wrote:
> 
> > > better than i ever got with 2.4 even when only one drive was on a channel.
> > > Right now my k7-2 750 is at 849mhz with a FSB of 114Mhz and PCI at 34Mhz.
> >
> > Hint: people who overclock machines get suprising odd results and bad stuff
> > happens. Please dont waste developers time unless you can reproduce it at
> > the intended speed for the components
> 
> Like i said .. i just did that within the last 5 min   it has nothing to do
> with any problems i've been talking about

Btw, if you run your FSB at 114 MHz, you need to pass 'idebus=38' to the
IDE driver so that it knows your PCI bus runs at 38 MHz (3x38 = 114).

Otherwise you'll get incorrect timing etc.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
