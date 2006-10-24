Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWJXHCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWJXHCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWJXHCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:02:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56497 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932403AbWJXHCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:02:40 -0400
Date: Tue, 24 Oct 2006 09:02:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH -mm] swsusp: Support i386 systems with PAE or without PSE
Message-ID: <20061024070231.GA4410@elf.ucw.cz>
References: <200610240045.19261.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610240045.19261.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-10-24 00:45:18, Rafael J. Wysocki wrote:
> Make swsusp support i386 systems with PAE or without PSE.
> 
> This is done by creating temporary page tables located in resume-safe
> page frames before the suspend image is restored in the same way
> as x86_64 does it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK (but still did not find time to test it).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
