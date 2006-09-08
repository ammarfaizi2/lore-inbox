Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWIHOkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIHOkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 10:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIHOkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 10:40:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10122 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750762AbWIHOks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 10:40:48 -0400
Date: Fri, 8 Sep 2006 16:39:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bernd Eckenfels <be-mail2006@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908143946.GD17680@elf.ucw.cz>
References: <20060907173449.GA24013@clipper.ens.fr> <E1GLPhz-0001T9-00@calista.eckenfels.net> <20060907230028.GB30916@elf.ucw.cz> <20060908012201.GA14280@lina.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908012201.GA14280@lina.inka.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-09-08 03:22:01, Bernd Eckenfels wrote:
> On Fri, Sep 08, 2006 at 01:00:28AM +0200, Pavel Machek wrote:
> > If attacker already has priviledge foo, he can just go use it. He does
> > not have to exec() poor program not expecting to get priviledge foo,
> > then abusing it.
> 
> It is not about attackers. It is about normal usage. If you spawn a program,
> it might behave wrong since it does not know that it is priveledged. For
> example a network daemon might start a child process which interacts with
> the user, and forgets to drop priveldges for it.

Well, then mistake was running that daemon with elevated priviledges
in the first place.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
