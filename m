Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbTEFV2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTEFV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:28:13 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:34266 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261915AbTEFV2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:28:12 -0400
Date: Tue, 6 May 2003 23:38:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl cleanups: move SG_IO translation where it belongs
Message-ID: <20030506213853.GA5615@elf.ucw.cz>
References: <20030506200311.GA5520@elf.ucw.cz> <1052252472.23104.11.camel@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052252472.23104.11.camel@averell>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This enables sharing of 200 lines of SG_IO support by all 64-bit
> > architectures. If it looks okay, more such patches will follow.
> 
> 
> I currently have some patches for this function pending. When an
> unchanged data buffer is passed it is ok to just verify_area it, no need
> to kmalloc and copy. This simplifies this handler vastly.
> 
> Here is the part from the 2.4 patch; haven't tried it with 2.5 yet,
> but should apply there too.
> 
> Also adds some boundary checking.

I'll merge it. Can you mail me whole 2.4 patch [I had it but deleted
it, sorry]. I'll attempt to port it to 2.5 and return it back to
you...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
