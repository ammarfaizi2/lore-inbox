Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVAHS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVAHS0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVAHS0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:26:13 -0500
Received: from [213.146.154.40] ([213.146.154.40]:46034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261244AbVAHS0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:26:07 -0500
Date: Sat, 8 Jan 2005 18:25:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: ross@lug.udel.edu
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050108182555.GA31512@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, ross@lug.udel.edu,
	Jack O'Quin <joq@io.com>, Chris Wright <chrisw@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
	paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050108165657.GA21760@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108165657.GA21760@jose.lug.udel.edu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:56:57AM -0500, ross@lug.udel.edu wrote:
> On Sat, Jan 08, 2005 at 12:12:59AM -0600, Jack O'Quin wrote:
> > I find it hard to understand why some of you think PAM is an adequate
> > solution.  As currently deployed, it is poorly documented and nearly
> > impossible for non-experts to administer securely.  On my Debian woody
> > system, when I login from the console I get one fairly sensible set of
> > ulimit values, but from gdm I get a much more permissive set (with
> > ulimited mlocking, BTW).  Apparently, this is because the `gdm' PAM
> > config includes `session required pam_limits.so' but the system comes
> > with an empty /etc/security/limits.conf.  I'm just guessing about that
> > because I can't find any decent documentation for any of this crap.
> > 
> > Remember, if something is difficult to administer, it's *not* secure.
> 
> Not to mention that not everyone chooses to use PAM for precisely this
> reason.  Slackware has never included PAM and probably never will.
> My audio workstation has worked swell with the 2.4+caps solution and
> the 2.6+LSM solution.  PAM would break me ::-(

you can set rmlimits as well without pam.  it's just more complicated.
But hey, it was you who didn't want to use it :)
