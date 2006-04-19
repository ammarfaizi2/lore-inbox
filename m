Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDSQmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDSQmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWDSQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:42:19 -0400
Received: from web36605.mail.mud.yahoo.com ([209.191.85.22]:8892 "HELO
	web36605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750975AbWDSQmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:42:18 -0400
Message-ID: <20060419164217.53082.qmail@web36605.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Wed, 19 Apr 2006 09:42:17 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <1145451264.24289.53.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> This would be fine, if the technical approach were
> sound (not necessarily the same as SELinux, but
sound)

Please accept that this is a judgement call.

> and fit properly with the LSM interface.

Of course LSM will fit SELinux better than it fits
AppArmour, LSM has been adapted to fit the needs
of SELinux. Once AppArmour, LIDS, and friends have
been accepted LSM will adjust to serve them better
just as it has done for SELinux. If the arguement
is that a module can't be accepted because it
doesn't do the same things SELinux does, and that
there's no point in accepting it if it does the
same things SELinux does I will admit that you have
all the bases covered.

> But the path-based approach isn't technically sound,

That is certainly true for a Common Criteria
system. There are clued individuals who understand
all the underlying technology who still care
about *any* file called /etc/shadow, chroot, mount,
vfs, and phase of the moon notwithstanding.

> and even if we were to assume that it was, it isn't
even
> a good fit for the LSM hook interfaces.

SELinux wasn't always a good fit either. LSM
accomodated SELinux. Offer the same community
cooperation to other you have yourself received.


Casey Schaufler
casey@schaufler-ca.com
