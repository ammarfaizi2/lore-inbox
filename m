Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVA0Sye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVA0Sye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVA0Sye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:54:34 -0500
Received: from gprs213-80.eurotel.cz ([160.218.213.80]:26240 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262702AbVA0Sya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:54:30 -0500
Date: Thu, 27 Jan 2005 19:54:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dan Malek <dan@embeddedalley.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add AMD Geode processor support
Message-ID: <20050127185412.GA1679@elf.ucw.cz>
References: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com> <20050127171555.GA3999@elf.ucw.cz> <FFF9B138-7089-11D9-AE1E-003065F9B7DC@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFF9B138-7089-11D9-AE1E-003065F9B7DC@embeddedalley.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >We do not disable HIGHMEM_64GB for 486, I do not see why we should add
> >extra code to geode...
> 
> What about some of the other ones like MTRR and IOAPIC?
> I was kinda passing this along from someone I thought knew
> better than I, but I didn't like it either.  It seems just setting these
> booleans to 'n' should do the trick.

Actually sorry, no, you can't do that.

486 should mean "can run on 486 or better" (at least in 2.4.X
series). That means it should have IOAPIC support compiled in.

Just do not play with HIGHMEM_64GB; someone may want a kernel for
"geode or better".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
