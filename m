Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270368AbTGMTsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTGMTsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:48:15 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4286 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S270368AbTGMTsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:48:14 -0400
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sun, 13 Jul 2003 22:03:55 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307112053.55880.kernel@kolivas.org> <20030712154924.GC15452@holomorphy.com>
In-Reply-To: <20030712154924.GC15452@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307132203.55414.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 July 2003 17:49, William Lee Irwin III wrote:
> On Fri, Jul 11, 2003 at 08:53:38PM +1000, Con Kolivas wrote:
> > Wli coined the term "isochronous" (greek for same time) for a real time
> > task that was limited in it's timeslice but still guaranteed to run. I've
> > decided to abuse this term and use it to name this new policy in this
> > patch. This is neither real time, nor guaranteed.
>
> I didn't coin it; I know of it from elsewhere.

Right, for example, USB has an isochronous transfer facility intended to 
support media applications, e.g., cameras, that require realtime 
bandwidth/latency guarantees.  The thing is, such guarantees have to be 
end-to-end in the media pipeline.  Sound is just one of the applications that 
needs the kind of realtime support we (or more properly, Davide) just 
proposed.

Regards,

Daniel

