Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWBPPnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWBPPnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWBPPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:43:53 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:32501 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932294AbWBPPnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:43:52 -0500
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060215213122.GA17450@elte.hu>
References: <20060215151711.GA31569@elte.hu>
	 <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
	 <20060215213122.GA17450@elte.hu>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 07:43:50 -0800
Message-Id: <1140104630.21681.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 22:31 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > >This patchset provides a new (written from scratch) implementation of
> > >robust futexes, called "lightweight robust futexes". We believe this new
> > >implementation is faster and simpler than the vma-based robust futex
> > >solutions presented before, and we'd like this patchset to be adopted in
> > >the upstream kernel. This is version 1 of the patchset.
> > 
> > 	Next point of discussion must be PI. [...]
> 
> robustness is an orthogonal feature to Priority Inheritance. In fact it 
> was requested before on lkml to separate robustness support from PI 
> support, and the vma-based robust futex patches now do precisely that - 
> they dont offer PI. So no, PI does not play here, it's a separate thing.

	I was more interested in knowing if you considered it in the design.

Daniel 

