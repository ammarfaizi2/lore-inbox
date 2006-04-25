Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWDYEHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWDYEHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWDYEHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:07:19 -0400
Received: from web36608.mail.mud.yahoo.com ([209.191.85.25]:52564 "HELO
	web36608.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751366AbWDYEHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:07:17 -0400
Message-ID: <20060425040716.72864.qmail@web36608.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 24 Apr 2006 21:07:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Olivier Galibert <galibert@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424132911.GB22703@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
 
> Ah yes.  It needed to be authoritative.  I did
> recall incorrectly.
> 
> I suspect some would argue that you are right that
> LSM is broken, but
> only because it wasn't allowed to be authoritative.

As I said at the time, I am disappointed that
authoritative hooks lost out, but it was hardly
the end of the world, and all in all, the LSM
that won out was a good first shot.

And of course, SGI's intent at the time was to
use LSM for audit. The prevailing attitude of
the day was that Linux would Never Allow Audit,
and a general scheme looked to be our best bet.
After LSM rejected authoritative hooks we
rewrote audit to use the accepted hook and,
get this, the Powers above canceled the project
the week we were to check it in.

I am happy to see the linux-audit project, and
happy to see POSIX ACLs as well. With an
authoritative LSM those would have been rolled
in and not required special interfaces of their
own. Oh well.

> Of course that
> was to increase chances of LSM upstream inclusion.

This was indeed a primary argument against
authoritative hooks, but the potential for
protrietary binary modules loomed large as
well.

> Sorry Casey and
> Linda,

Ack. That association was strictly corporate.
Please disregard.

> I bet that just makes it sting all the harder
> if LSM is now
> removed for not being sufficiently useful.

Eh, I've been right in the past and I've been
wrong in the past. I've had more code thrown out
of systems than a lot of you have ever written,
so an interface vector that's proven unpopular
isn't going to bring me down much.


Casey Schaufler
casey@schaufler-ca.com
