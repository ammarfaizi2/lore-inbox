Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVAHQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVAHQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVAHQ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:56:59 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:7558 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S261216AbVAHQ45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:56:57 -0500
From: ross@lug.udel.edu
Date: Sat, 8 Jan 2005 11:56:57 -0500
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050108165657.GA21760@jose.lug.udel.edu>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzvkxxck.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:12:59AM -0600, Jack O'Quin wrote:
> I find it hard to understand why some of you think PAM is an adequate
> solution.  As currently deployed, it is poorly documented and nearly
> impossible for non-experts to administer securely.  On my Debian woody
> system, when I login from the console I get one fairly sensible set of
> ulimit values, but from gdm I get a much more permissive set (with
> ulimited mlocking, BTW).  Apparently, this is because the `gdm' PAM
> config includes `session required pam_limits.so' but the system comes
> with an empty /etc/security/limits.conf.  I'm just guessing about that
> because I can't find any decent documentation for any of this crap.
> 
> Remember, if something is difficult to administer, it's *not* secure.

Not to mention that not everyone chooses to use PAM for precisely this
reason.  Slackware has never included PAM and probably never will.
My audio workstation has worked swell with the 2.4+caps solution and
the 2.6+LSM solution.  PAM would break me ::-(

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
