Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWDTPk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWDTPk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWDTPk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:40:26 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:22731 "EHLO
	gotham.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1751042AbWDTPkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:40:25 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Joshua Brindle <method@gentoo.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org, Tony Jones <tonyj@suse.de>
In-Reply-To: <1145535423.3313.15.camel@moss-spartans.epoch.ncsc.mil>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145535423.3313.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 11:38:53 -0400
Message-Id: <1145547534.14302.7.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 08:17 -0400, Stephen Smalley wrote:
> On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote: 
> > AppArmor is an LSM security enhancement for the Linux kernel. The
> > primary goal of AppArmor is to make it easy for a system administrator
> > to control application behavior, enforcing that the application has
> > access to only the files and POSIX.1e draft capabilities it requires to
> > do its job. AppArmor deliberately uses this simple access control model
> > to make it as easy as possible for the administrator to manage the
> > policy, because the worst security of all is that which is never
> > deployed because it was too hard.
> 
> The worst security is that which doesn't do what it claims to do, giving
> a false sense of security.  Which is precisely the problem with
> path-based access control; it makes the user think that he is protecting
> a given object, when in fact the object may be accessible by another
> means.

I've compiled a list of security related issues with path based access
control at
http://securityblog.org/brindle/2006/04/19/security-anti-pattern-path-based-access-control/

I intentionally avoided specific implementations and OS related issues
to focus on the security aspects. Note that not all path based access
control implementations are subject to all these problems but some are
common to all.

Joshua Brindle

