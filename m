Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTDOTZZ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTDOTZY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:25:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10195 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264037AbTDOTZY (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 15:25:24 -0400
Date: Tue, 15 Apr 2003 21:37:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
Message-ID: <20030415193709.GR9640@fs.tum.de>
References: <20030414222110.GK9640@fs.tum.de> <20030414222723.GA26161@suse.de> <1050357987.26525.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050357987.26525.24.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:06:28PM +0100, Alan Cox wrote:
> On Llu, 2003-04-14 at 23:27, Dave Jones wrote:
> > On Tue, Apr 15, 2003 at 12:21:10AM +0200, Adrian Bunk wrote:
> >  > If my patch is wrong and this is a RTFM please give me a hint where to 
> >  > find the "M".
> >  > 
> >  > The AMD K6-II and K6-III do support 3DNow!
> > 
> > The 3dnow memory copies aren't a win on anything
> > earlier than an Athlon iirc.
> 
> Under 1% on a K6. The processor is so horribly memory bound the
> actual copy function is borderline irrelevant. If its not in the
> K6-III cache its not arriving in a hurry

Ah thanks, this is the information I didn't know.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

