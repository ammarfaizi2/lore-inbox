Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWDQUIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWDQUIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWDQUIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:08:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46290 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750848AbWDQUIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:08:37 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060417195146.GA8875@kroah.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 22:08:23 +0200
Message-Id: <1145304503.2847.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> But for removing LSM entirely, I'm starting to like your patch.  It's
> been a very long time and so far, only out-of-tree LSMs are present,
> with no public statements about getting them submitted into the main
> kernel tree.  And, I think almost all of the out-of-tree modules already
> need other kernel patches to get their code working properly, so what's
> a few more hooks needed...

and if it really cripples the one real user of the API.. then it's
clearly a wrong thing and it should be fixed (by going away and going
direct instead).

As for your argument about the bickering... well... afaics most of the
people who originally in the game quietly went away once it was clear
that LSM exports were _GPL only .. or when their modules were reviewed
and shown to be architecturally broken.

Who's left today?

