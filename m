Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbTIZRBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIZRBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:01:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:53916 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261459AbTIZRBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:01:09 -0400
Date: Fri, 26 Sep 2003 18:59:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
Message-ID: <20030926165957.GA11150@ucw.cz>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262208.30582.mhf@linuxmail.org> <yw1x3cejlk34.fsf@users.sourceforge.net> <200309262332.30091.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309262332.30091.mhf@linuxmail.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 11:32:30PM +0800, Michael Frank wrote:
> On Friday 26 September 2003 22:07, M?ns Rullg?rd wrote:
> > Michael Frank <mhf@linuxmail.org> writes:
> > 
> > > Suspect chipset related issue which should be looked into.
> > 
> > That's what someone told me three months ago, too.  Nothing happened,
> > though.
> > 
> 
> OK, now that we are two, we copy the IDE maintainer ;)

Actually, it's me who wrote the 961 and 963 support. It works fine for
most people. Did you check you cabling?

> 
> I guess it is fair to say that we are happy to test patches.
> 
> And here is my lspci -vv.
> 
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 128
>         Interrupt: pin ? routed to IRQ 10
>         Region 4: I/O ports at 4000 [size=16]
>         Capabilities: <available only to root>
> 
> 
> Regards
> Michael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
