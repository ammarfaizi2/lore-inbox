Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319591AbSH3Ph1>; Fri, 30 Aug 2002 11:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319597AbSH3Ph1>; Fri, 30 Aug 2002 11:37:27 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:9373 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S319591AbSH3Ph0>; Fri, 30 Aug 2002 11:37:26 -0400
Date: Fri, 30 Aug 2002 18:42:25 +0300
From: Anssi Saari <as@sci.fi>
To: Markus Plail <plail@web.de>
Cc: Sergio Bruder <sergio@bruder.net>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is enabled
Message-ID: <20020830154225.GA6114@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Markus Plail <plail@web.de>, Sergio Bruder <sergio@bruder.net>,
	Andre Hedrick <andre@linux-ide.org>, vojtech@ucw.cz,
	linux-kernel@vger.kernel.org
References: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org> <20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net> <87d6s0g9eq.fsf@plailis.homelinux.net> <20020830065142.GA10582@sci.fi> <874rdcg62f.fsf@plailis.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874rdcg62f.fsf@plailis.homelinux.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 09:27:04AM +0200, Markus Plail wrote:
> * Anssi Saari writes:
> >I doubt that's the problem. As I've said before, I don't have this huge
> >slowdown problem if I plug the writer to a Promise pdc20265 or CMD649,
> >neither of which supports DMA for ATAPI devices. These controllers
> >however abort CD writing randomly so they are not a workaround... 
> 
> Well, they may very well just deal better with PIO modes.
> 
> >I also don't have your DAO vs. TAO problem.
> 

> Hmm.. you wrote that cdrdao gives the problem, but cdrecord
> doesn't. 

I doubt that. Even if I did, it's wrong.

> And in a previous mail you wrote that you also have the
> problems when writing audio CDs. 

Yes. Audio CDs and VCDs, to be exact. Probably anything other than
vanilla ISO9660.

> Are you sure that you really used DAO when using cdrecord? 

Yes, I do that quite a lot since DAO is a requirement for overburning,
on my writers anyway. For both data and audio CDs. I just tried it
again. It makes no noticeable difference, -dao or not. Data write good,
audio write bad.

