Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWD1QLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWD1QLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWD1QLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:11:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:48050 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030489AbWD1QLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:11:47 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
 security: AppArmor - Overview
Date: Fri, 28 Apr 2006 09:04:25 -0700
Organization: OSDL
Message-ID: <20060428090425.160194e6@localhost.localdomain>
References: <1146229328.11817.73.camel@moss-spartans.epoch.ncsc.mil>
	<20060428154928.40409.qmail@web36603.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1146240264 32323 10.8.0.54 (28 Apr 2006 16:04:24 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 28 Apr 2006 16:04:24 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 08:49:27 -0700 (PDT)
Casey Schaufler <casey@schaufler-ca.com> wrote:

> 
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
> a pain in the bum and will remain so. Tools are going
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

The problem I see looking from the outside at this discussion is that
SELinux and AppArmor have two different goals. AppArmor like no-execute
is more targeted at preventing an existing application with well defined
behavior from doing something wrong.  Like other tools of this type:
virus scanners, etc; it works to prevent the known good applications
from turning rogue. The problem is that listing all the allowed behavior
for all applications would be impossible.

SELinux on the other hand takes a real security view of the world. If
you have ever worked with real security environment with "need to
know", you will understand that it is hard to keep secure and requires
too many restrictions for normal users.
