Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTLHUlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTLHUlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:41:25 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:5250 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262056AbTLHUlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:41:24 -0500
Date: Mon, 8 Dec 2003 15:40:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Per Andreas Buer <perbu@linpro.no>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
In-Reply-To: <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
Message-ID: <Pine.LNX.4.58.0312081539490.5919@montezuma.fsmlabs.com>
References: <1070897058.25490.56.camel@netstat.linpro.no>
 <20031208153641.GJ8039@holomorphy.com> <1070898870.25490.76.camel@netstat.linpro.no>
 <20031208162214.GW19856@holomorphy.com> <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Per Andreas Buer wrote:

> William Lee Irwin III <wli@holomorphy.com> writes:
>
> > If your memory ended at 2GB and the driver had 31-bit DMA, it may have
> > decided to use unconstrained allocations. Then, when you added more RAM,
> > it was forced to ask for <= 896MB, which made it copy to buffers that are
> > actually below 896MB most of the time.
>
> But this would reduce the throuput only a few percent, right? My system
> slows down from writing ~ 100MB/s to maybe 50KB/s.

How is overall system performance, ie non disk IO related?
