Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTJJIrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTJJIrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:47:43 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15772 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262617AbTJJIrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:47:41 -0400
Date: Fri, 10 Oct 2003 17:47:37 +0900
From: YoshiyaETO <eto@soft.fujitsu.com>
Subject: Re: 2.7 thoughts
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org,
       Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be
Message-id: <04d501c38f0b$2864c210$6a647c0a@eto>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
 <20031009115809.GE8370@vega.digitel2002.hu>
 <20031009165723.43ae9cb5.skraw@ithnet.com>
 <3F864F82.4050509@longlandclan.hopto.org>
 <20031010063039.GA700@holomorphy.com> <047b01c38f00$60b34840$6a647c0a@eto>
 <20031010074030.GB700@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see any reason to connect it with the notion of a node.
    If the word "Node" is not so appropriate, I will use "Unit".
And I also make it simple, "Unit" will have CPUs and/or Memory.
On the other hand IO-Unit will have IOs.

> The main points of contention would appear to be cooperative vs.
> forcible (where I believe cooperative is acknowledged as the only
    I could not understand what is forcible.
Everything should be cooperative, I think.

----- Original Message ----- 
From: "William Lee Irwin III" <wli@holomorphy.com>
To: "YoshiyaETO" <eto@soft.fujitsu.com>
Cc: "Stuart Longland" <stuartl@longlandclan.hopto.org>;
<linux-kernel@vger.kernel.org>; "Stephan von Krawczynski"
<skraw@ithnet.com>; <lgb@lgb.hu>; <Fabian.Frederick@prov-liege.be>
Sent: Friday, October 10, 2003 4:40 PM
Subject: Re: 2.7 thoughts


> On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> >>> * hotplug motherboard & entire computer too I spose ;-)
>
> > From: "William Lee Irwin III" <wli@holomorphy.com>
> >> Um, this is worse than the above wrt. being too vague.
>
> On Fri, Oct 10, 2003 at 04:30:27PM +0900, YoshiyaETO wrote:
> > "Hotplug node" is a better explanation, I think.
> > "Node" includes CPUs and/or Memory and/or some kind of IOs.
> > And "Node" should be flexibly configurable also.
>
> I don't see any reason to connect it with the notion of a node.
>
> The main points of contention would appear to be cooperative vs.
> forcible (where I believe cooperative is acknowledged as the only
> feasible problem), and the potential connections with ZONE_HIGHMEM
> wrt. constraints that would artificially introduce to 64-bit kernels.
>
> The fact some systems would want to do whole nodes at a time with
> some cpus and io buses in tandem is largely immaterial and doesn't
> simplify, complicate, or otherwise affect the VM mechanics.
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

