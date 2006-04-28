Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWD1Q6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWD1Q6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWD1Q6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:58:09 -0400
Received: from tresys.irides.com ([216.250.243.126]:7638 "EHLO
	exchange.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1751399AbWD1Q6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:58:07 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Karl MacMillan <kmacmillan@tresys.com>
To: casey@schaufler-ca.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       Andi Kleen <ak@suse.de>, Ken Brush <kbrush@gmail.com>,
       Neil Brown <neilb@suse.de>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060428154928.40409.qmail@web36603.mail.mud.yahoo.com>
References: <20060428154928.40409.qmail@web36603.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Apr 2006 12:56:05 -0400
Message-Id: <1146243365.15747.40.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 08:49 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
> > But this is a temporary situation, until we have the
> > infrastructure and
> > tools developed to make MAC truly manageable by
> > typical end users.  Not
> > an inherent problem.
> 
> Oh come on! I've been hearing that saw continueously
> since 1987. Mandatory MAC (as opposed to targeted MAC)
> is hard on sysadmins. It will remain so. SELinux,
> Trusted Solaris, Trusted IRIX, and anyone else are all
> a pain in the bum and will remain so.

Grouping SELinux with previous trusted systems doesn't make sense to me.

Administering non-MLS SELinux systems is already easier than
administering traditional MAC systems like Trusted Solaris and Trusted
IRIX. Much of the pain from tradition MAC systems comes from the
mismatch between MLS and the real world of unix and unix administration.
I know that you will disagree with this because you believe that MLS and
BIBA are simplier than TE, but that doesn't match my experience or the
feedback we get from our customers.


Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> Tools are going
> to help only to a limited extent, they never make all
> the pain go away. Smarter people than I have been
> working on the problem for 20 years and I believe that
> it's safe to say there is no magic wand that will
> make the problems all go away.
> 
> I like MAC. I like the Iron Fist approach to software
> security. I just don't believe that there's a glove
> with velvet thick enough to please the masses.
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com

