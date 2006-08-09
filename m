Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030706AbWHILij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030706AbWHILij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030707AbWHILij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:38:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50827 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030706AbWHILii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:38:38 -0400
Date: Wed, 9 Aug 2006 13:38:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Message-ID: <20060809113822.GQ3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608092047.13493.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608092047.13493.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Comments welcome.
> 
> Thanks for the reminder. I'd forgotten half the reason why I didn't want to 
> make Suspend2 into incremental patches! You're a brave man!

Why does this serve as a reminder? No, it is not easy to merge big
patches to mainline. But it is actually a feature.

> while (1) {
>   size=$RANDOM * 65536 + 1
>   dd if=/dev/random bs=1 count=$size | patch -p0-b
>   make && break
>}

Is this what you use to generate suspend2 patches? :-)))))

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
