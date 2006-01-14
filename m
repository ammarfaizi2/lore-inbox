Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWANJnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWANJnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWANJnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:43:39 -0500
Received: from havoc.gtf.org ([69.61.125.42]:37019 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751636AbWANJni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:43:38 -0500
Date: Sat, 14 Jan 2006 04:43:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Adrian Bunk <bunk@stusta.de>, Tim Tassonis <timtas@cubic.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-ID: <20060114094333.GA9510@havoc.gtf.org>
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de> <43C3B7C8.8000708@cubic.ch> <20060110141324.GJ3911@stusta.de> <20060111203731.GF2456@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111203731.GF2456@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 08:37:32PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > Like the OSS/Alsa or XFree3.x/XFree4.x situations.
> > 
> > And OSS/ALSA is an example why this is not a good thing:
> > - OSS in the kernel is unmaintained
> > - people forced to use OSS drivers can't use applications only 
> >   supporting ALSA
> 
> Well, it is different. Current ieee80211 stack is going to be
> maintained by Intel -- because they need it for their hw.
> And it will be very easy to find maintainer for the new stack...
> 
> So we already have two-stack situation here.

No, ieee80211 has always been intended for use by all drivers.
Read the archives... there have been a few efforts to start merging
HostAP and ieee80211 code, and further efforts exist out of tree that
add softmac support.

Remember Linux's maxim:  do what you must, and no more.

That implies that new users SHOULD update ieee80211 for their needs.

	Jeff



