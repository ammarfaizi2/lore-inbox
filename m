Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWGIWk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWGIWk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWGIWk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:40:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31691 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161206AbWGIWk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:40:28 -0400
Date: Mon, 10 Jul 2006 00:35:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick <mccpat@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17.4] Halting process powers-off HDD twice
Message-ID: <20060709223538.GA1807@elf.ucw.cz>
References: <9834b6670607071625w7bbf7721i26b90d23e94bac75@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9834b6670607071625w7bbf7721i26b90d23e94bac75@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-07-07 19:25:48, Patrick wrote:
> I'm using the 2.6.17.4 kernel. As of the 2.6.17 release, whenever I
> shutdown my system (using the 'halt' command... I didn't change the
> 'halt' version since the update), my hard-drive powers off, powers
> back on, powers off, and then the system is powered down. Usually (<=
> 2.6.16), the hard-drive would be turned off once, and then the system
> powered off.
> 
> The hard-drive this problem is occuring on is an IDE Maxtor 6B300R0
> hard drive. My .config is attached. Please CC me, as I'm not
> subscribed to the list.

Can you add WARN_ON(1) to the spindown code and get tracebacks to
see who is causing this?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
