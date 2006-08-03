Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWHCRFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWHCRFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHCRFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:05:11 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:61957 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932579AbWHCREy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:04:54 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Date: Thu, 3 Aug 2006 18:04:55 +0100
User-Agent: KMail/1.9.3
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, mchan@broadcom.com
References: <20060803075704.GC27835@thunk.org> <20060803163204.GB20603@thunk.org> <20060803094917.8280f5ff.rdunlap@xenotime.net>
In-Reply-To: <20060803094917.8280f5ff.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608031804.55292.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 17:49, Randy.Dunlap wrote:
[snip]
> > This only shows up with the real-time kernel where timer softirq's run
> > in their own processes, and a high priority process preempts the timer
> > softirq.  I don't really consider this a networking bug, or even
> > driver bug, although it does seem unfortunate that Broadcom hardware
> > locks up and goes unresponsive if the OS doesn't tickle it every tenth
> > of a second or so.  (Definitely a bad idea if the tg3 gets used on any
> > laptops, from a power usage perspective.)  But that seems like a
> > (lame) hardware bug, not a driver bug....
>
> Interesting.  On my Dell D610 notebook with tg3 and vpn,
> I have to ping a server on the vpn to keep it alive, otherwise
> it disappears soon and I have to restart the vpn.  Of course,
> this could just be the vpn or some other software problem
> instead of a tg3 problem.

Probably. I have an NC6000 with a tg3 and have never experienced link failure 
problems, even under -rt.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
