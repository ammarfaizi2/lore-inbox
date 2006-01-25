Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWAYPDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWAYPDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAYPDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:03:12 -0500
Received: from mail.shareable.org ([81.29.64.88]:21453 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751189AbWAYPDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:03:11 -0500
Date: Wed, 25 Jan 2006 15:02:43 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060125150243.GA8490@mail.shareable.org>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl> <1138181033.4800.4.camel@tara.firmix.at> <1138182179.3087.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138182179.3087.1.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-01-25 at 10:23 +0100, Bernd Petrovitsch wrote:
> > 
> > ACK. X, evolution and Mozilla family (to name standard apps) are the
> > exceptions to this rule. 
> 
> If you decrease RLIMIT_STACK from the default 8MB to 256KB or 512KB you
> will reduce the footprint of multithreaded apps like evolution by tens
> or hundreds of MB, as glibc sets the thread stack size to RLIMIT_STACK
> by default.

That should make no difference to the real memory usage.  Stack pages
which aren't used don't take up RAM, and don't count in RSS.

-- Jamie
