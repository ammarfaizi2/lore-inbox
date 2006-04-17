Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWDQX0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWDQX0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWDQX0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:26:16 -0400
Received: from web36602.mail.mud.yahoo.com ([209.191.85.19]:21397 "HELO
	web36602.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751384AbWDQX0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:26:15 -0400
Message-ID: <20060417232614.33983.qmail@web36602.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 17 Apr 2006 16:26:14 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1145309184.14497.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> You can implement a BSD securelevel model in SELinux
> as far as I can see
> from looking at it,

Well, to seriously mangle quotes,
you can implement any policy you want
with SELinux, so long as Tresys puts
it in.

> and do it better than the code today, so its not
> really a feature drop anyway just a migration away
> from some fossils

Dagnabbit, my scales are showing again.

And y'all are right, In tree users of LSM
are a might thin. Sounds as if those who
would use it need to push to get their code
accepted really hard. That means getting
past the inevitable arguement that "you can
do it with SELinux".


Casey Schaufler
casey@schaufler-ca.com
