Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVK3Bni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVK3Bni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVK3Bni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:43:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37347 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbVK3Bnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:43:37 -0500
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
	<200511292247.09243.rjw@sisk.pl>
From: Andi Kleen <ak@suse.de>
Date: 29 Nov 2005 23:11:49 -0700
In-Reply-To: <200511292247.09243.rjw@sisk.pl>
Message-ID: <p73iruahdga.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, 29 of November 2005 05:11, Linus Torvalds wrote:
> > 
> > I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> > diffstats appended.
> 
> Hangs solid on boot on dual-core Athlon64.  No details yet, but I'm working
> on them.  I wonder if anyone else is seeing this.

I also see a hang in EHCI on my single A64 VIA box, but curiously
it goes away with pci=noacpi (but that might just cover it - i 
had a buggy USB storage device in the front usb ports and 
I think with noacpi it just doesn't route them correctly) 
Didn't investigate closer so far.

-Andi
