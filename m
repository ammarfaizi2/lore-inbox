Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVBKKqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVBKKqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 05:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVBKKqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 05:46:36 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:54029 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S262243AbVBKKqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 05:46:30 -0500
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
From: Arjan van de Ven <arjan@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>,
       Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20050210183934.GF20153@logos.cnet>
References: <420631BF.7060407@pobox.com> <420582C6.7060407@pobox.com>
	 <58cb370e05020607197db9ecf4@mail.gmail.com> <420BB77B.3080508@tmr.com>
	 <58cb370e05021012051518e912@mail.gmail.com>
	 <58cb370e0502101404e4ddefa@mail.gmail.com>
	 <20050210183934.GF20153@logos.cnet>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 05:46:19 -0500
Message-Id: <1108118779.4055.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2005 10:46:20.0180 (UTC) FILETIME=[EBDC1D40:01C51026]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 16:39 -0200, Marcelo Tosatti wrote:

> What do you mean "adds another incompatibility" ? 
> 
> That users will have to switch to dmraid when upgrading to v2.6.x ? 

which is a rather disruptive and incompatible change. device names
change etc etc.


> SATA is not the same case as sw-RAID in my POV Bart, it allows many 
> users to be _able_ use SATA controllers/drives. 

without sata in the kernel, those were still driven by the legacy ide
driver, just not as fast/optimal.


