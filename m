Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWIUVbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWIUVbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWIUVbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:31:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15271 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751584AbWIUVbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:31:46 -0400
Date: Thu, 21 Sep 2006 23:31:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 4/6] swsusp: Add resume_offset command line parameter
Message-ID: <20060921213143.GE2245@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609202146.59105.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202146.59105.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add the kernel command line parameter "resume_offset=" allowing us to specify
> the offset, in <PAGE_SIZE> units, from the beginning of the partition pointed
> to by the "resume=" parameter at which the swap header is located.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Okay, I'd prefer not to add aditional features to in-kernel swsusp,
but this is just not big enough to reject.

ACK.

(What is the solution for uswsusp?)
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
