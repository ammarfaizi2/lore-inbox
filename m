Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWISWB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWISWB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWISWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:01:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9667 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751171AbWISWBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:01:46 -0400
Date: Tue, 19 Sep 2006 21:16:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH 7/7] SLIM: documentation
Message-ID: <20060919191643.GA7246@elf.ucw.cz>
References: <1158083888.18137.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158083888.18137.18.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Documentation.

Thanks for it.

> +file /etc/resolv.conf, dbus-daemon, which accepts data from
> +potentially untrusted processes, Xorg, which has to accept data
> +from all Xwindow clients, regardless of level, and postfix which
> +delivers untrusted mail. Again, these applications inherently
> +must cross trust levels, and SLIM properly identifies them.

How is this supposed to work. Xorg was not designed to be security
barrier. So... your exploited evolution, but evolution is now
UNTRUSTED, so you can't do anything interesting... right?

Wrong. evolution can ask Xorg to simulate "rm -rf /" keypresses, and
send them to your shell in another window...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
