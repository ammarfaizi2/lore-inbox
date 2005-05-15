Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVEOVLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVEOVLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVEOVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 17:11:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46509 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261243AbVEOVLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 17:11:01 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116190107.6270.34.camel@laptopd505.fenrus.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>
	 <1116089068.6007.13.camel@laptopd505.fenrus.org>
	 <1116093396.9141.11.camel@mindpipe>
	 <1116093694.6007.15.camel@laptopd505.fenrus.org>
	 <1116098504.9141.31.camel@mindpipe>
	 <1116100126.6007.17.camel@laptopd505.fenrus.org>
	 <1116114052.9141.38.camel@mindpipe>
	 <1116142233.6270.9.camel@laptopd505.fenrus.org>
	 <1116189693.17990.1.camel@localhost.localdomain>
	 <1116190107.6270.34.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 15 May 2005 17:10:59 -0400
Message-Id: <1116191459.10653.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-15 at 22:48 +0200, Arjan van de Ven wrote:
> On Sun, 2005-05-15 at 21:41 +0100, Alan Cox wrote:
> > On Sul, 2005-05-15 at 08:30, Arjan van de Ven wrote:
> > > stop entirely.... (and that is also happening more and more and linux is
> > > getting more agressive idle support (eg no timer tick and such patches)
> > > which will trigger bios thresholds for this even more too.
> > 
> > Cyrix did TSC stop on halt a long long time ago, back when it was worth
> > the power difference.
> 
> With linux going to ACPI C2 mode more... tsc is defined to halt in C2...

JACK doesn't care about any of this now, the behavior when you
suspend/resume with a running jackd is undefined.  Eventually we should
handle it, but there's no point until the ALSA drivers get proper
suspend/resume support.

Lee

