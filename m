Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWJWPLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWJWPLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWJWPLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:11:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22975 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964907AbWJWPK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:10:59 -0400
Date: Mon, 23 Oct 2006 17:10:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Quieten Freezer if !CONFIG_PM_DEBUG
Message-ID: <20061023151054.GA1994@elf.ucw.cz>
References: <1161560140.7438.56.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161560140.7438.56.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The freezer currently prints an '=' for every process that is frozen.
> This is pretty pointless, as the equals sign says nothing about which
> process is frozen, and makes logs look messier (especially if there were
> a large number of processes running). All we really need to know is that
> we started trying to freeze processes and what processes (if any) failed
> to freeze, or that we succeeded.

> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

ACK.
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
