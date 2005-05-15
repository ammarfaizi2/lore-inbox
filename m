Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVEODT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVEODT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 23:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEODT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 23:19:26 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:22976 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261466AbVEODTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 23:19:22 -0400
Date: Sat, 14 May 2005 20:19:21 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@redhat.com>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <1116100126.6007.17.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0505142013080.1621@twinlark.arctic.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>  <m164xnatpt.fsf@muc.de>
 <1116009483.4689.803.camel@rebel.corp.whenu.com>  <20050513190549.GB47131@muc.de>
 <20050513212620.GA12522@hexapodia.org>  <20050513215905.GY5914@waste.org> 
 <1116024419.20646.41.camel@localhost.localdomain>  <1116025212.6380.50.camel@mindpipe>
  <20050513232708.GC13846@redhat.com>  <1116027488.6380.55.camel@mindpipe> 
 <1116084186.20545.47.camel@localhost.localdomain>  <1116088229.8880.7.camel@mindpipe>
  <1116089068.6007.13.camel@laptopd505.fenrus.org>  <1116093396.9141.11.camel@mindpipe>
  <1116093694.6007.15.camel@laptopd505.fenrus.org>  <1116098504.9141.31.camel@mindpipe>
 <1116100126.6007.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2005, Arjan van de Ven wrote:

> it's a matter of time (my estimate is a year or two) before processors
> get variable frequencies based on temperature targets etc...
> and then rdtsc is really useless for this kind of thing..

what do you mean "a year or two"?  processors have been doing this for 
many years now.

i'm biased, but i still think transmeta did this the right way... the tsc 
operates at the top frequency of the processor always.

i do a hell of a lot of microbenchmarking on various processors and i 
always use tsc -- but i'm just smart enough to take multiple samples and i 
try to make each sample smaller than a time slice... which avoids most of 
the pitfalls, and would even work on smp boxes with tsc differences.

-dean
