Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUDBKjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUDBKjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:39:35 -0500
Received: from gprs212-243.eurotel.cz ([160.218.212.243]:8322 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263584AbUDBKjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:39:33 -0500
Date: Fri, 2 Apr 2004 12:39:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402103923.GB677@elf.ucw.cz>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401164825.GD791@holomorphy.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
> > guess google also won't dislike it.
> > This is a lot simpler than the mlock rlimit and this is people really
> > need (not the rlimit). The rlimit thing can still be applied on top of
> > this. This should be more efficient too (besides its simplicity).
> > can you apply to mainline?
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc3-aa1/disable-cap-mlock-1
> 
> Something like this would have the minor advantage of zero core impact.
> Testbooted only. vs. 2.6.5-rc3-mm4

I thought this is what setpcap in init is for?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
