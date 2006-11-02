Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752060AbWKBKbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbWKBKbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWKBKbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:31:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19919 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752060AbWKBKba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:31:30 -0500
Date: Thu, 2 Nov 2006 11:31:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Message-ID: <20061102103119.GG1990@elf.ucw.cz>
References: <200610221548.48204.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610221548.48204.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The purpose of the appended patch is to make swsusp work on i386 with PAE,
> but it should also allow i386 systems without PSE to use swsusp.
> 
> The patch creates temporary page tables located in resume-safe page frames
> during the resume and uses them for restoring the suspend image (the same
> approach is used on x86-64).
> 
> It has been tested on an i386 system with PAE and survived several
> suspend-resume cycles in a row, but I have no systems without PSE, so that
> requires some testing.
> 
> Comments welcome.

Just a short update. I actualy tried it, and it seems to work
ok. Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
