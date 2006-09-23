Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWIWKR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWIWKR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 06:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWIWKR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 06:17:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60804 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751467AbWIWKR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 06:17:27 -0400
Date: Sat, 23 Sep 2006 12:17:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] swsusp: Add support for swap files
Message-ID: <20060923101724.GA20778@elf.ucw.cz>
References: <200609231158.00147.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609231158.00147.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following series of patches makes swsusp support swap files.
> 
> For now, it is only possible to suspend to a swap file using the in-kernel
> swsusp and the resume cannot be initiated from an initrd.
> 
> [Note to Pavel: I have added a couple of paragraphs to the documentation to
> clarify some things pointed out by Dave, but I hope the ACK still applies. ;-) ]

Yes, thanks.

Out of my curiosity... can swap on file work on filesystems with 1K
blocksize? ext2 can do that, iirc...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
