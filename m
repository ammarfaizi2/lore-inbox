Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWBMEke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWBMEke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 23:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWBMEke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 23:40:34 -0500
Received: from pop-7.dnv.wideopenwest.com ([64.233.207.25]:28893 "EHLO
	pop-7.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S1751610AbWBMEkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 23:40:33 -0500
Date: Sun, 12 Feb 2006 23:40:29 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060213044029.GF7450@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
	Phillip Susi <psusi@cfl.rr.com>
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com> <20060212080727.GE7450@squish.home.loc> <43EFD38F.30600@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EFD38F.30600@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com>, on Sun Feb 12, 2006 [07:32:15 PM] said:
> Paul wrote:
> >
> >	This is not technically true; once the pktcdvd mapping is made,
> >the device can be accessed like a r/w block device. For example, after
> >I associate the dvd with the pktcdvd device, I then can associate it
> >with a cryptographic loop device, and mke2fs on that, then mount it
> >and use it like any other filesystem. Something like:
> 
> You must first format the cd-rw in packet mode with cdrwtool before 
> pktcdvd can write to it.
> 

	Hi;

	Ah, I havent used a cd-rw in quite some time; I recall now
that I had to do an initial format on the dvd-rw with dvd+rw-format,
but had never used cdrwtool in the process. Thanks for the correction.

Paul
set@pobox.com
