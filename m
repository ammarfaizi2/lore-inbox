Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759268AbWK3QsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268AbWK3QsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759271AbWK3QsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:48:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10634 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1759268AbWK3QsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:48:10 -0500
Date: Thu, 30 Nov 2006 17:48:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Lynch <ntl@pobox.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, bryce@osdl.org
Subject: Re: CPU hotplug broken with 2GB VMSPLIT
Message-ID: <20061130164800.GA1860@elf.ucw.cz>
References: <20061130090348.GK5400@kernel.dk> <20061130091334.GM5400@kernel.dk> <20061130164347.GB22050@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130164347.GB22050@localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Some more clues - booting with noreplacement doesn't fix it, so I think
> > the alternatives code is off the hook.
> 
> I don't think this adds any new information, but it has been open
> awhile:
> 
> http://bugme.osdl.org/show_bug.cgi?id=6542
> 
> I was able to narrow it down to the vmsplit setting but I wasn't able
> to debug it further.

Can we at least add error return or something? Or make CPU_HOTPLUG
depend on "normal" VM split, or...? Having s2ram breaking for known
problem is annoying...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
