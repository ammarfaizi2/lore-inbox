Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVHFBh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVHFBh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVHFBh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:37:26 -0400
Received: from smtp.istop.com ([66.11.167.126]:452 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261862AbVHFBhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:37:24 -0400
From: Daniel Phillips <phillips@istop.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: lockups with netconsole on e1000 on media insertion
Date: Sat, 6 Aug 2005 11:37:25 +1000
User-Agent: KMail/1.7.2
Cc: Andi Kleen <ak@suse.de>, John B?ckstrand <sandos@home.se>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <20050805235122.GI8266@wotan.suse.de> <20050806012219.GZ8074@waste.org>
In-Reply-To: <20050806012219.GZ8074@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508061137.26281.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 August 2005 11:22, Matt Mackall wrote:
> On Sat, Aug 06, 2005 at 01:51:22AM +0200, Andi Kleen wrote:
> > > But why are we in a hurry to dump the backlog on the floor? Why are we
> > > worrying about the performance of netpoll without the cable plugged in
> > > at all? We shouldn't be optimizing the data loss case.
> >
> > Because a system shouldn't stall for minutes (or forever like right now)
> > at boot just because the network cable isn't plugged in.
>
> Using netconsole without a network cable could well be classified as a
> serious configuration error.

But please don't.  An OS that slows to a crawl or crashes because a cable 
isn't plugged in an OS that deserves to be ridiculed.  Silly timeouts on boot 
are scary and a waste of user's time.

Regards,

Daniel
