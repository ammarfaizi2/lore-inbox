Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWHAV55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWHAV55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHAV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:57:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:21465 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751161AbWHAV55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:57:57 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, sergio@sergiomb.no-ip.org
Subject: Re: [discuss] Re: [PATCH for 2.6.18] [2/8] x86_64: On Intel systems when CPU has C3 don't use TSC
Date: Tue, 1 Aug 2006 23:56:52 +0200
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de> <200608011910.25110.ak@suse.de> <1154468420.2991.5.camel@localhost.portugal>
In-Reply-To: <1154468420.2991.5.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012356.52893.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 23:40, Sergio Monteiro Basto wrote:
> On Tue, 2006-08-01 at 19:10 +0200, Andi Kleen wrote:
> > > I had some faith in this patch , but this just enable boot parameter
> > > notsc (which I already use). And "just" disable tsc don't solve all
> > the
> > > problems.
> > 
> > What problems do you have?
> > 
> Hi Andi ,
> if I boot without notsc , I have many lost timer tickets.

Lost timer ticks print a rip. Do you have some samples?

Anyways, for a single socket Intel dual core TSCs should be definitely
synced so I don't know what could be wrong on your system. 
Please post full boot.msg at least.

-Andi
