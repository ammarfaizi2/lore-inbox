Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVDLWqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVDLWqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVDLWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:42:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:31910 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263017AbVDLWlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:41:32 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <871x9fg96h.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de> <1113276365.5387.39.camel@gaston>
	 <87u0mc8v2p.fsf@blackdown.de> <1113287657.5387.46.camel@gaston>
	 <871x9fg96h.fsf@blackdown.de>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 08:40:00 +1000
Message-Id: <1113345600.5387.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>> Hrm... I just noticed you have CONFIG_PREEMPT enabled... Can you
> >>> test without it and let me know if it makes a difference ?
> >>
> >> IIRC I had disabled that for rc2-mm2 and it didn't make a
> >> difference.  I'll disable it again when I try older versions.
> >>
> >> I just got another crash with rc2-mm3.  The crash was a bit
> >> different this time, I still could move the mouse pointer and the
> >> logs contained some info:
> >
> > Ok, what about non-mm  ? (just plain rc2)
> 
> I've tried older kernels now.  rc1-mm1 locks up (no logs); plain rc1
> seems to be OK (running fine for several hours now).

Interesting. Please try -rc2 too...

Ben.


