Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWHQXCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWHQXCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWHQXCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:02:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46282 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965147AbWHQXCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:02:34 -0400
Date: Fri, 18 Aug 2006 01:02:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-ID: <20060817230213.GA18786@elf.ucw.cz>
References: <1155844419.6788.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155844419.6788.62.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Documentation.

No, I still do not understand how this is supposed to work.

> +In normal operation, the system seems to stabilize with a roughly
> +equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most

So you split processes to three classes (why three?), and
automagically move them between classes based on some rules? (What
rules?)

Like if I'm UNTRUSTED process, I may not read ~/.ssh/private_key? So
files get this kind of labels, too? And it is "mozilla starts as a
USER, but when it accesses first web page it becomes UNTRUSTED"?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
